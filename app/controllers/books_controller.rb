class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.where(user_id: @user.id)
    if @book.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book)
    else
      render("users/show")
    end
  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
    @user = User.find(@book_show.user_id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render("books/edit")
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      @book.destroy
      redirect_to books_path
    else
      redirect_to user_path(current_user)
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
      redirect_to books_path
    end
  end

end
