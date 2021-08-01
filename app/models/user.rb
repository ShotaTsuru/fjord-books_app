# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_follow, # フォローする側の中間テーブルの定義
    class_name: "FollowRelationship",
    foreign_key: "following_id"
  has_many :followings, through: :active_follow, source: :follower 


  has_many :passive_follow, # フォローされている側の中間テーブルの定義
    class_name: "FollowRelationship",
    foreign_key: "followers_id"
  has_many :followers, through: :passive_follow, source: :following

end
