# frozen_string_literal: true

class UserApp::UserSerializer < ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  include Constants
  attributes :id, :email, :first_name, :last_name, :image, :is_notifiable, :phone_number,
             :gender, :status, :deleted_at, :must_change_password

  attribute :country do |object|
    Lookups::CountrySerializer.new(object.country).to_j
  end

  attribute :is_classical do |object|
    object.classic_account?
  end

  attribute :is_phone_verified do |object|
    object.phone_verified_at?
  end

  attribute :is_email_verified do |object|
    object.email_verified_at?
  end

  attribute :auth_token, if: proc { |_record, params| params && params[:auth_token] } do |_object, params|
    params[:auth_token]
  end

  ############################## Show details ##############################

  attributes :date_of_birth, :gender, if: proc { |_record, params| params && params[:show_details] }

  attribute :can_resend_sms, if: proc { |_record, params| params && params[:show_details] } do |object|
    object.sms_verification_count < MAX_NUMBER_OF_RESEND_VERIFICATION_TRIES
  end
end
