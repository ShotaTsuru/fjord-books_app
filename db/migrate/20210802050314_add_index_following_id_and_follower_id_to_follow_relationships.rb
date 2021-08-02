class AddIndexFollowingIdAndFollowerIdToFollowRelationships < ActiveRecord::Migration[6.1]
  def change
    add_index :follow_relationships, [:following_id, :follower_id], unique: true
  end
end
