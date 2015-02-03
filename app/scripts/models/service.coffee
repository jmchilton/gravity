AppModel = require('scripts/models/app')

class Service extends AppModel
  urlRoot: 'services'

  initialize: () ->
    name = @get('name')
    group = @get('group')
    id = if (name == group) then name else (group + ":" + name)
    @set('id', id)
    super

  start: () ->
    @save(
      state: 'start'
    ,
      wait: true
    )

  stop: () ->
    @save(
      state: 'stop'
    ,
      wait: true
    )


module.exports = Service
