ServicesListView = require('scripts/views/services/list')
template = require('templates/layouts/services_layout')

class ServicesLayout extends Marionette.LayoutView
  template: template

  regions:
    servicesRegion: '#services_list_region'

  onRender: ->
    @servicesRegion.show(new ServicesListView(collection: @collection))

module.exports = ServicesLayout
