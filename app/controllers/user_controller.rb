class UserController < ApplicationController
  def index
    @user = current_user
    @books = @user.books
  end
end
