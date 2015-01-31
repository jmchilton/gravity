AppConfig = require('scripts/config')

class AppCollection extends Backbone.Collection
  initialize: ->
    @url = AppConfig.apiPath + _.result(@, 'url')
    super

  sync: (method, model, options) ->
    options.data = _.extend({}, options.data)

    super


module.exports = AppCollection
