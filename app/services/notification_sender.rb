# frozen_string_literal: true

# TODO: to be tested
class NotificationSender
  require 'fcm'

  def initialize(args)
    @user_device_ids = args[:user_device_ids]
    @title = args[:title]
    @body = args[:body]
    @data = args[:data]
    @badge = args[:badge]
  end

  def call
    @user_device_ids.each_slice(20) do |user_device_id|
      fcm_client.send(user_device_id, options)
    end
  end

  private

  def options
    {
      data: @data,
      notification: {
        title: @title,
        body: @body,
        sound: 'default',
        badge: @badge
      }
    }
  end

  def fcm_client
    @fcm_client ||= FCM.new(ENV.fetch('FCM_SERVER_KEY', nil))
  end
end
