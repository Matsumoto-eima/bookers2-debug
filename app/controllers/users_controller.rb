class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def index
     @book = Book.new
   @users = User.all
    @user = current_user
     @book_new = Book.new
  end

  def edit
     user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to current_user
  end
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def follows
  user = User.find(params[:id])
  @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

def followers
  user = User.find(params[:id])
  @users = user.follower_user.page(params[:page]).per(3).reverse_order
end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
