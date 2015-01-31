BaseRouter = require('scripts/routers/base')

class ServicesRouter extends BaseRouter
  navigation: 'services'

  appRoutes:
    'services': 'index'
    'services/:id': 'show'

module.exports = ServicesRouter
