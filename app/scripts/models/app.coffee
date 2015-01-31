AppConfig = require('scripts/config')

class AppModel extends Backbone.Model
  initialize: ->
    @urlRoot = AppConfig.apiPath + _.result(@, 'urlRoot')
    super

  sync: (method, model, options) ->
    if method in ['create', 'update', 'patch']
      data = model.toJSON()
      options.data = JSON.stringify(data)
      options.contentType = 'application/json'
    else
      options.data = _.extend({}, options.data)

    super

module.exports = AppModel
