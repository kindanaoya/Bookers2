class BooksController < ApplicationController
  def new
    @books = Book.all

  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    if @user.id == current_user.id
      render :edit
    else
      redirect_to books_path
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update

    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

   private

  def book_params
    params.require(:book).permit(:title, :profile_image, :body)
  end


end
