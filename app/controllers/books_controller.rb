class BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]
  before_action :set_permitted_params, only: %i[create update]
  before_action :authorize_book, only: %i[update destroy]

  def index
    @pagy, @books = pagy(Book.includes(:author).apply_filters(params), page: params[:page])
    render_success BookSerializer.new(@books).serializable_hash 
  end

  def show
    authorize @book
    render_success BookSerializer.new(@book, params:{include_description: true, include_published_date: true} ).serializable_hash
  end

  def create
    authenticate_request
    @book = Book.new(@permitted_params)
    authorize @book
    @book.save!
    render_success(message: 'Book created successfully')
  end

  def update
    @book.update!(@permitted_params)
    render_success(message: 'Book updated successfully')
  end

  def destroy
    @book.destroy!
  end

  private
  def set_book
    @book = Book.find(params[:id])
  end

  def authorize_book
    authorize @book
  end

  def set_permitted_params
    @permitted_params = params.permit(:title, :author_id, :description, :published_date)
  end
end

#Queries
# user, @user, @@user
