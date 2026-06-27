'use strict';
'require view';
'require form';
'require rpc';

var callInitAction = rpc.declare({
	object: 'luci',
	method: 'setInitAction',
	params: [ 'name', 'action' ],
	filter: function(res) { return res; }
});

return view.extend({
	render: function() {
		var m, s, o;

		m = new form.Map('nat66', _('NAT66 Configuration'),
			_('Quickly configure IPv6 NAT (NAT66) and resolve routing advertisement gateway issues.'));

		s = m.section(form.TypedSection, 'nat66', _('Settings'));
		s.anonymous = true;
		s.addremove = false;

		o = s.option(form.Flag, 'enabled', _('Enable NAT66'));
		o.rmempty = false;
		o.default = '0';

		o = s.option(form.Value, 'wan_dev', _('WAN Interface'),
			_('Select the WAN interface for IPv6 NAT (e.g. wan, wan6, pppoe-wan)'));
		o.rmempty = false;
		o.default = 'wan';
		o.value('wan');
		o.value('wan6');

		o = s.option(form.ListValue, 'ula_mode', _('LAN Prefix Mode'),
			_('Choose the IPv6 prefix assigned to LAN devices.<br/>'
			+ '<b>Random ULA</b>: Standard private fd00::/8 prefix (RFC 4193). Devices know it is not public IPv6.<br/>'
			+ '<b>6bone Legacy</b>: Uses the deprecated 3ffe::/16 range (RFC 3701, returned to IANA). '
			+ 'Devices see what looks like a public prefix, encouraging IPv6-first behaviour. '
			+ 'No real ISP uses this range — safe for NAT66.<br/>'
			+ '<b>Custom</b>: Specify your own prefix.'));
		o.rmempty = false;
		o.default = 'random';
		o.value('random', _('Random ULA (fd00::/8)'));
		o.value('6bone', _('6bone Legacy (3ffe::/16)'));
		o.value('custom', _('Custom Prefix'));

		o = s.option(form.Value, 'ula_prefix', _('Custom LAN Prefix'),
			_('Enter a custom IPv6 prefix (e.g. fd12:3456:7890::/48). Only used when mode is "Custom".'));
		o.rmempty = true;
		o.default = '';
		o.datatype = 'cidr6';
		o.depends('ula_mode', 'custom');

		return m.render();
	},

	handleSaveApply: function(ev, mode) {
		return this.super('handleSaveApply', [ev, mode]).then(function() {
			return callInitAction('nat66', 'restart');
		});
	}
});
