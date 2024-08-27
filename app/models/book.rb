class Book < ApplicationRecord
  belongs_to :author
  validates :title, presence: true
  validates :author, presence: true
  scope :title_like, ->(title) { where('title ILIKE ?', "%#{title}%") }
  scope :author_like, ->(author) { joins(:author).where('authors.name ILIKE ?', "%#{author}%") }
  scope :published_after, ->(date) { where('published_date > ?', Date.parse(date)) if date.present? }
  scope :published_before, ->(date) { where('published_date < ?', Date.parse(date)) if date.present? }
  scope :apply_filters, ->(params) { title_like(params[:title]).author_like(params[:author]).published_after(params[:published_at_start]).published_before(params[:published_at_end]) }
  
  def self.get_index_attrs
    %w[id title author_name]
  end

  def self.get_show_attrs
    %w[id title description published_date]
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
