# frozen_string_literal: true

class UserApp::UserAppNotificationSerializer < ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :is_seen, :created_at

  attribute :title do |object, params|
    object.notification_template_title(locale: params[:locale])
  end

  attribute :body do |object, params|
    object.notification_template_body(locale: params[:locale])
  end

  attribute :click_action do |object|
    object.notification_template_click_action
  end

  attribute :action_id do |object|
    object.notification_template_action_id
  end
end
