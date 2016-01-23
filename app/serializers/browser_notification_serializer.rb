class BrowserNotificationSerializer < ActiveModel::Serializer
  self.root = 'notification'

  attributes :id, :payload
end
