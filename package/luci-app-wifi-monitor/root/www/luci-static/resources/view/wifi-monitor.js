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

		o = s.option(form.ListValue, 'sta', _('Monitored STA Interface'),
			_('Select which STA (Client) interface to monitor. Leave empty for auto-detect (first connected). Use this when you have multiple STA interfaces on the same radio, e.g. for mwan3 link aggregation.'));
		o.rmempty = true;
		o.default = '';
		o.value('', _('Auto-detect (first connected)'));

		// Populate STA options dynamically from wireless configuration
		var stas = uci.sections('wireless', 'wifi-iface');
		if (stas && stas.length > 0) {
			stas.forEach(function(s) {
				if (s.mode === 'sta') {
					o.value(s['.name'], s['.name'] + (s.ssid ? ' (SSID: ' + s.ssid + ')' : ''));
				}
			});
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

		// Simple inline status indicator — no button-like border/padding
		return m.render().then(function(mapNode) {
			var dotColor   = isRunning ? '#10b981' : '#ef4444';
			var statusText = isRunning ? _('Active (Monitoring)') : _('Inactive (Stopped)');

			// Keyframe for running-dot pulse glow (scoped name avoids theme conflicts)
			var styleNode = E('style', {},
				'@keyframes wifimon-pulse {' +
				'0%, 100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.4); }' +
				'50%      { box-shadow: 0 0 0 5px rgba(16, 185, 129, 0); }' +
				'}'
			);

			var statusNode = E('div', { 'class': 'cbi-section' }, [
				E('div', { 'class': 'cbi-value' }, [
					E('label', { 'class': 'cbi-value-title' }, _('Running State')),
					E('div', { 'class': 'cbi-value-field' }, [
						E('span', { 'style': 'font-weight: 500;' }, [
							E('span', {
								'style': 'display: inline-block; width: 10px; height: 10px; border-radius: 50%;'
								       + ' background-color: ' + dotColor + '; margin-right: 6px; vertical-align: middle;'
								       + (isRunning ? ' animation: wifimon-pulse 2s ease-in-out infinite;' : '')
							}),
							statusText
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
