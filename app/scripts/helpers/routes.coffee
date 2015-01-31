class RoutesHelper
  @rootPath: -> '#'
  @servicesPath: -> "#services"
  @servicePath: (id) -> "#services/#{id}"

module.exports = RoutesHelper
