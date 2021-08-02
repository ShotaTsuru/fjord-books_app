# frozen_string_literal: true

class FollowRelationshipsController < ApplicationController
  def create
    follow = current_user.active_follow.build(follower_id: params[:user_id])
    follow.save
    redirect_to user_path(params[:user_id])
    binding.irb
  end

  def destroy
    follow = current_user.active_follow.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to user_path(params[:user_id])
  end
end
