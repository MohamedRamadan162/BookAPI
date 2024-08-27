class BookSerializer
  include JSONAPI::Serializer
  attributes :title, :author_name
  attribute :description, if: Proc.new { |record, params| params[:include_description] }
  attribute :published_date, if: Proc.new { |record, params| params[:include_published_date] }
  attribute :author_name do |book|
    book.author.name
  end
end
