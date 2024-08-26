FactoryBot.define do
  factory :book do
    title { "MyString" }
    author { nil }
  end
end

# == Schema Information
#
# Table name: books
#
#  id             :bigint           not null, primary key
#  description    :text
#  published_date :date
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  author_id      :bigint           not null
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => authors.id)
#
