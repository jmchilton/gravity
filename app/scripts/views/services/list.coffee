ServiceItemView = require('scripts/views/services/item')

class ServicesListView extends Marionette.CollectionView
  tagName: 'ul'
  className: 'list-group'
  childView: ServiceItemView

module.exports = ServicesListView
