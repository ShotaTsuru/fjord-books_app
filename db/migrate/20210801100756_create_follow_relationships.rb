class CreateFollowRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_relationships do |t|
      t.integer :following_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
