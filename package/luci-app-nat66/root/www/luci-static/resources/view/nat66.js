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

		return m.render();
	},

	handleSaveApply: function(ev, mode) {
		return this.super('handleSaveApply', [ev, mode]).then(function() {
			return callInitAction('nat66', 'restart');
		});
	}
});
