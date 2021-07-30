class UserController < ApplicationController
  def index
   @users = User.order(:id).page params[:page]
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.order(:id).page params[:page]
  end

end
