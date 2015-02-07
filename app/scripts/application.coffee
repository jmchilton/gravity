Marionette = require('marionette')

App = new Marionette.Application

class ModalRegion extends Marionette.Region
  el: "#modal"

  onShow: () ->
    @showModal(this)

  getEl: (selector) ->
    $(selector).on("hidden", this.close)

  showModal: (view) ->
    view.on("close", @hideModal, this)
    this.$el.modal('show')

  hideModal: () ->
    this.$el.modal('hide')


App.addRegions
  navigationRegion: '#navigation_region'
  mainRegion: '#main_region'
  modal: ModalRegion

App.navigate = (route, options) ->
  options or= {}
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
