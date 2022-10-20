class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.ordered
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Your book was successfully published." }
        format.turbo_stream { flash.now[:notice] = "Your book was successfully published." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Your book was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Your book was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Your book was successfully deleted." }
      format.turbo_stream { flash.now[:notice] = "Book was successfully deleted" }
    end
  end

  private

  def set_book
    @book = current_user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :image, :description)
  end
end
