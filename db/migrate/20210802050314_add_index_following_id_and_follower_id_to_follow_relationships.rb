# frozen_string_literal: true

class AddIndexFollowingIdAndFollowerIdToFollowRelationships < ActiveRecord::Migration[6.1]
  def change
    add_index :follow_relationships, %i[following_id follower_id], unique: true
  end
end
