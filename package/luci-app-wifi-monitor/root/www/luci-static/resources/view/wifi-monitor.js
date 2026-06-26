'use strict';
'require view';
'require form';
'require rpc';
'require uci';

var callInitAction = rpc.declare({
	object: 'luci',
	method: 'setInitAction',
	params: [ 'name', 'action' ],
	filter: function(res) { return res; }
});

var callServiceList = rpc.declare({
	object: 'service',
	method: 'list',
	params: [ 'name' ],
	filter: function(res) { return res; }
});

return view.extend({
	load: function() {
		return Promise.all([
			uci.load('wifi-monitor'),
			uci.load('wireless'),
			callServiceList('wifi-monitor').then(function(res) {
				try {
					return res['wifi-monitor'] && res['wifi-monitor']['instances'] && res['wifi-monitor']['instances']['main'] && res['wifi-monitor']['instances']['main']['running'];
				} catch (e) {
					return false;
				}
			})
		]);
	},

	render: function(data) {
		var isRunning = data[2];
		var m, s, o;

		m = new form.Map('wifi-monitor', _('Wi-Fi Channel Monitor & Sync'),
			_('Monitors wireless interfaces in dual STA/AP modes to keep the local AP alive and sync channels when the upstream channel drifts.'));

		// Settings Section
		s = m.section(form.TypedSection, 'wifi-monitor', _('Settings'));
		s.anonymous = true;
		s.addremove = false;

		o = s.option(form.Flag, 'enabled', _('Enable Monitor'));
		o.rmempty = false;
		o.default = '0';

		o = s.option(form.ListValue, 'radio', _('Target Wireless Radio'), _('Select the physical radio to monitor. Both STA and AP must be on this radio.'));
		o.rmempty = false;
		o.default = 'radio0';
		
		// Populate radio options dynamically from wireless configuration
		var radios = uci.sections('wireless', 'wifi-device');
		if (radios && radios.length > 0) {
			radios.forEach(function(r) {
				o.value(r['.name']);
			});
		} else {
			o.value('radio0', 'radio0');
		}

		o = s.option(form.Value, 'interval', _('Check Interval (seconds)'), _('How frequently to check connection status.'));
		o.rmempty = false;
		o.default = '30';
		o.datatype = 'uinteger';
		o.value('10', _('10 seconds'));
		o.value('30', _('30 seconds (Recommended)'));
		o.value('60', _('1 minute'));
		o.value('120', _('2 minutes'));

		o = s.option(form.Flag, 'scan_disable_ap', _('Disable AP during scan'), 
			_('Temporarily disable local AP interfaces to ensure clean scanning. Only enable this if scanning fails on your wireless driver.'));
		o.rmempty = false;
		o.default = '0';

		o = s.option(form.ListValue, 'log_level', _('Log Level'));
		o.rmempty = false;
		o.default = '1';
		o.value('0', _('Quiet'));
		o.value('1', _('Standard'));
		o.value('2', _('Verbose / Debug'));

		// Prepend a beautiful custom status card at the top of the map
		return m.render().then(function(mapNode) {
			var styleNode = E('style', {},
				'@keyframes pulse { 0% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7); } 70% { transform: scale(1); box-shadow: 0 0 0 6px rgba(16, 185, 129, 0); } 100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); } }' +
				'.monitor-status-badge { display: inline-flex; align-items: center; gap: 8px; padding: 6px 12px; border-radius: 20px; font-weight: bold; font-size: 0.9rem; }' +
				'.monitor-status-badge.running { background: rgba(16, 185, 129, 0.15); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.3); }' +
				'.monitor-status-badge.stopped { background: rgba(239, 68, 68, 0.15); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.3); }' +
				'.monitor-dot { width: 8px; height: 8px; border-radius: 50%; }' +
				'.monitor-dot.running { background-color: #10b981; animation: pulse 2s infinite; }' +
				'.monitor-dot.stopped { background-color: #ef4444; }'
			);

			var statusNode = E('div', { 'class': 'cbi-section' }, [
				E('legend', {}, _('Service Status')),
				E('div', { 'class': 'cbi-value' }, [
					E('label', { 'class': 'cbi-value-title' }, _('Running State')),
					E('div', { 'class': 'cbi-value-field' }, [
						E('div', { 'class': 'monitor-status-badge ' + (isRunning ? 'running' : 'stopped') }, [
							E('span', { 'class': 'monitor-dot ' + (isRunning ? 'running' : 'stopped') }),
							E('span', {}, isRunning ? _('Active (Monitoring)') : _('Inactive (Stopped)'))
						])
					])
				])
			]);

			mapNode.insertBefore(statusNode, mapNode.firstChild);
			mapNode.insertBefore(styleNode, mapNode.firstChild);
			return mapNode;
		});
	},

	handleSaveApply: function(ev, mode) {
		return this.super('handleSaveApply', [ev, mode]).then(function() {
			return callInitAction('wifi-monitor', 'restart');
		});
	}
});
