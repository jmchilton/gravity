App = require('scripts/application')
Router = require('scripts/routers/services')
Controller = require('scripts/controllers/services_controller')

Services = App.module('Services')

Services.addInitializer ->
  controller = new Controller
  @router = new Router(controller: controller)

Services.on 'start', ->
  console.log 'module services started'

module.exports = Services
