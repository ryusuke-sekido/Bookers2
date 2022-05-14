class UsersController < ApplicationController
 def top
 end

 def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
     redirect_to book_path(@book.id)
    else
     render :new
    end
 end

 def index
  @user = current_user
  @users = User.all
  @book = Book.new
 end

 def show
  @user=User.find(params[:id])
  @books=@user.books
  
 end

 def edit
     @user=User.find(params[:id])
     redirect_to user_path(current_user) unless @user == current_user
 end

 def update
    @user =User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] ='successfully!!'
     redirect_to user_path(@user.id)
    else
     flash[:alert] = "error"
     render :edit
    end
 end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
