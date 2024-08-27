# frozen_string_literal: true

class User < ApplicationRecord
  include Constants
  ########################## Delegation #########################

  ############################ Enums ############################

  ######################### Validations #########################
  has_secure_password validations: false
  has_many :devices_tokens
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }

  ######################### Associations ########################

  ########################### Scopes ############################

  ############################ Hooks ############################

  ###################### Non db attributes ######################

  ########################### Methods ###########################
  def username
    "#{first_name} #{last_name}"
  end

  def forgot_password
    forgot_password_code = SecureRandom.urlsafe_base64
    self.forgot_password_digest = Digest::SHA256.hexdigest(forgot_password_code)
    self.forgot_password_digest_created_at = Time.current
    self.is_forgot_password_code_used = false
    save!
    send_forgot_password_email(forgot_password_code)
  end
    
  def send_forgot_password_email(token)
    link =
    "localhost:3000/users/reset_password?email=#{CGI.escape(email)}&forgot_password_code=#{token
    }"
    DefaultMailer.default_email('forgot_password', self, link).deliver_later
  end

  def validate_forgot_password_code(forgot_password_code)
    errors.add(:base, I18n.t('forgot_password_code_used_before'), strict: true) if is_forgot_password_code_used
    errors.add(:forgot_password_code, :invalid, strict: true) unless correct_forgot_password_code?(forgot_password_code)
    return unless forgot_password_code_expired? errors.add(:base, I18n.t('forgot_password_code_expired'), strict: true)
  end

  def correct_forgot_password_code?(code)
    code.present? && forgot_password_digest.eql?(Digest::SHA256.hexdigest(code))
  end

  def forgot_password_code_expired?
    forgot_password_digest_created_at.change(sec: 0) +
    Constants::FORGOT_PASSWORD_EXPIRY_DURATION < Time.current.change(sec: 0)
  end

  def reset_password(reset_password_params)
    validate_forgot_password_code(reset_password_params[:forgot_password_code])
    self.devices_tokens = []
    self.password = reset_password_params[:password]
    self.is_forgot_password_code_used = true
    save!
  end
  
end

# == Schema Information
#
# Table name: users
#
#  id                                :bigint           not null, primary key
#  date_of_birth                     :datetime
#  email                             :string
#  first_name                        :string
#  forgot_password_digest            :string
#  forgot_password_digest_created_at :datetime
#  gender                            :integer
#  image                             :string
#  is_forgot_password_code_used      :boolean          default(FALSE)
#  last_name                         :string
#  locale                            :string           default("en")
#  password_digest                   :string
#  status                            :integer
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  country_id                        :bigint
#
# Indexes
#
#  index_users_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
