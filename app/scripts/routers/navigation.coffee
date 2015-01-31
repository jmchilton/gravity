App = require('scripts/application')
BaseRouter = require('scripts/routers/base')
routes = require('scripts/helpers/routes')

class NavigationRouter extends BaseRouter
  initialize: ->
    @listenTo Backbone.history, 'route', @onNavigationChange

  onNavigationChange: (router) ->
    App.vent.trigger 'navigation:change', router.navigation

module.exports = NavigationRouter
