AppModel = require('scripts/models/app')

class Service extends AppModel
  urlRoot: 'services'

  defaults:
    'service': ''

  validation:
    service:
      required: true


module.exports = Service
