class BooksController < ApplicationController


  def new
    @book =Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
     flash[:notice] ='successfully!!'
     redirect_to book_path(@book.id)
    else
     flash[:alert] = "error"
     @user=@book.user
     @books=Book.all
     render :index
    end
  end

  def index
    @books = Book.all
    @book =Book.new
    @user=current_user
    
    
  end

  def show
    @book=Book.find(params[:id])
    @user=@book.user
  end

  def edit
     @book = Book.find(params[:id])
     @user = @book.user
     redirect_to(books_path) unless @user == current_user
     
  end

   def update
    @book =Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] ='successfully!!'
     redirect_to book_path(@book.id)
    else
     flash[:alert] = "error"
     render :edit
    end
   end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


   private

  def book_params
    params.require(:book).permit(:title, :body)
  end



end