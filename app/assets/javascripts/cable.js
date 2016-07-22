// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the rails generate channel command.
//
//= require action_cable
//= require_self

(function() {
  this.PdmApp || (this.PdmApp = {});

  PdmApp.cable = ActionCable.createConsumer();

}).call(this);
