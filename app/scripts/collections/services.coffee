AppCollection = require('scripts/collections/app')
Service = require('scripts/models/service')

class ServiceCollection extends AppCollection
  url: 'services'
  model: Service

module.exports = ServiceCollection
