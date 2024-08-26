class BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]
  def list
    puts params
    start_date = params[:published_at_start].present? ? Date.parse(params[:published_at_start]) : nil
    end_date = params[:published_at_end].present? ? Date.parse(params[:published_at_end]) : nil
    @pagy, @books = pagy(Book.includes(:author).title_like(params[:title]).author_like(params[:author]).published_after(start_date).published_before(end_date),
     page: params[:page])
    wanted_attrs = %w[id title author_id]
    books_json = @books.as_json(only: wanted_attrs).map do |book|
      book.merge(author_name: Author.includes(:books).find(book['author_id']).name).except('author_id') 
    end
    render_success(books: books_json)
    
  end

  def show
    wanted_attrs = %w[id title description published_date]
    render_success(book: @book.as_json(only: wanted_attrs).merge(author_name: @book.author.name))
  end

  def create
    permitted_params = params.permit(:title, :author_id, :description, :published_date)
    @book = Book.create!(permitted_params)
    # authorize @book
    render_success(message: 'Book created successfully')
  end

  def update
    # authorize @book
    permitted_params = params.permit(:title, :author_id, :description, :published_date)
    @book.update!(permitted_params)
    render_success(message: 'Book updated successfully')
  end

  def destroy
    # authorize @book
    Book.find(params[:id]).destroy!
  end
  private
  def set_book
    @book = Book.find(params[:id])
  end
end
