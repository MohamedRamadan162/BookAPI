FactoryBot.define do
  factory :author do
    name { "MyString" }
  end
end

# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
