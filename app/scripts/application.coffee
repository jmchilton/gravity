App = new Marionette.Application

App.addRegions
  navigationRegion: '#navigation_region'
  mainRegion: '#main_region'

App.navigate = (route, options) ->
  options or= {}
  console.log route
  Backbone.history.navigate(route, options)

App.on 'start', ->
  Backbone.history.start
    pushState: false
    root: '#'

  $(document).on 'click', '.js-link', (event) ->
    event.preventDefault()
    href = $(event.currentTarget).attr('href')
    App.navigate(href, trigger: true)

module.exports = App
