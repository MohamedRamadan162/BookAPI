class DevicesToken < ApplicationRecord
  belongs_to :user
end

# == Schema Information
#
# Table name: devices_tokens
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  device_id  :string
#  user_id    :bigint           not null
#
# Indexes
#
#  index_devices_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
