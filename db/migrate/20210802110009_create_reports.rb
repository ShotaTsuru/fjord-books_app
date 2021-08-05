class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :text
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
