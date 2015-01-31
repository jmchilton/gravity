App = require('scripts/application')
ServicesLayout = require('scripts/views/layouts/services_layout')
ServicesShowView = require('scripts/views/services/item')
Service = require('scripts/models/service')
Services = require('scripts/collections/services')

class ServicesController extends Marionette.Controller
  index: ->
    services = new Services
    services.fetch().then ->
      App.mainRegion.show(new ServicesLayout(collection: services))

  show: (id) ->
    model = new Service(id: id)

    model.fetch().then ->
      App.mainRegion.show(new ServicesShowView(model: model))

module.exports = ServicesController
