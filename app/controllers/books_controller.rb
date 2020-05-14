class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book)
    else
      render("users/show")
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
