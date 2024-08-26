class Book < ApplicationRecord
  belongs_to :author
  validates :title, presence: true
  validates :author, presence: true
  scope :title_like, ->(title) { where('title ILIKE ?', "%#{title}%") }
  scope :author_like, ->(author) { joins(:author).where('authors.name ILIKE ?', "%#{author}%") }
  scope :published_after, ->(date) { where('published_date > ?', date) if date.present? }
  scope :published_before, ->(date) { where('published_date < ?', date) if date.present? }
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
