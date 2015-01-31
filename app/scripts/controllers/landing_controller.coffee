App = require('scripts/application')
ContentLandingView = require('scripts/views/content/landing')
Routes = require('scripts/helpers/routes')

class LandingController extends Marionette.Controller
  index: ->
    path = Routes.servicesPath()
    console.log path
    App.navigate path, { trigger: true }

module.exports = LandingController
