NavigationNavigationView = require('scripts/views/navigation/navigation')
Routes = require('scripts/helpers/routes')
template = require('templates/layouts/navigation_layout')

class NavigationLayout extends Marionette.LayoutView
  className: 'container-fluid'
  template: template

  regions:
    navigationRegion: '#navigation_region'

  templateHelpers:
    routes: Routes

  onRender: ->
    navigationNavView = new NavigationNavigationView
    @navigationRegion.show(navigationNavView)

module.exports = NavigationLayout
