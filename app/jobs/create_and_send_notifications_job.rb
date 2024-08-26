# frozen_string_literal: true

class CreateAndSendNotificationsJob < ApplicationJob
  def perform(args)
    @locale_path = args[:locale_path]
    @opts = args[:opts]
    @action_id = args[:action_id]
    @click_action = args[:click_action]
    @namespaced_recipients = args[:namespaced_recipients]
    @icon = args[:icon]
    create_and_send_notifications
  end

  def create_and_send_notifications
    notifications_attributes = { action_id: @action_id, locale_path: @locale_path, opts: @opts, click_action: @click_action, icon: @icon }

    @namespaced_recipients&.each do |namespace, recipients|
      recipients_with_type = recipients.flat_map do |type, recipient_ids|
        model_name = type.to_s.camelcase
        recipient_ids.map { |recipient_id| { recipient_type: model_name, recipient_id: recipient_id } }
      end

      notifications_attributes.merge!("#{namespace.to_s.underscore.downcase}_notifications_attributes".to_sym => recipients_with_type)
    end
    NotificationTemplate.create!(notifications_attributes)
  end
end
