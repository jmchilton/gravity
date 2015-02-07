App = require('scripts/application')
routes = require('scripts/helpers/routes')
template = require('templates/services/item')
ServiceLog = require('scripts/models/service_log')
ServicesLogView = require('scripts/views/services/log')

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
    'click [action=stdoutlog]': 'stdout'
    'click [action=stderrlog]': 'stderr'

  start: (e) ->
    @model.start()

  stop: (e) ->
    @model.stop()

  stdout: (e) ->
    console.log(e)
    @model.stdout (contents) ->
      model = new ServiceLog({"contents": contents})
      view = new ServicesLogView({model: model})
      App.modal.show view

  stderr: (e) ->
    console.log(e)
    @model.stderr (contents) ->
      model = new ServiceLog({"contents": contents})
      view = new ServicesLogView({model: model})
      App.modal.show view

module.exports = ServicesItemView
