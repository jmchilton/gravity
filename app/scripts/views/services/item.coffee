App = require('scripts/application')
routes = require('scripts/helpers/routes')
template = require('templates/services/item')

class ServicesItemView extends Marionette.ItemView
  tagName: 'a'
  className: ->
    'list-group-item list-group-item-' + @getStatus()

  template: template

  templateHelpers:
    routes: routes

  serializeData: ->
    _.extend super, {'status': @getStatus()}

  getStatus: ->
    statename = @model.get('statename')
    if statename in ['STOPPED', 'BACKOFF', 'STOPPING', 'EXITED']
      'warning'
    else if statename in ['FATAL']
      'danger'
    else
      'success'

  events:
    'click [action=start]': 'start'
    'click [action=stop]': 'stop'

  start: (e) ->
    @model.start()

  stop: (e) ->
    @model.stop()


module.exports = ServicesItemView
