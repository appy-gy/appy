storages =
  BaseStorage: require './storages/base_storage'
  CurrentUserStorage: require './storages/current_user_storage'
  RatingsStorage: require './storages/ratings_storage'

module.exports = storages