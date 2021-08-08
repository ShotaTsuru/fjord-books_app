# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def follows
    @user = User.find(params[:user_id])
    @followings = @user.followings.order(:id).page(params[:page])
  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers.order(:id).page(params[:page])
  end
end
