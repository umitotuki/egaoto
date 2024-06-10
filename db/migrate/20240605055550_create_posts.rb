class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id,null: false
      t.integer :genre_id,null: false
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :is_draft, null: false, default: true
      t.timestamps
    end
  end
end
