class CreatePostCommentents < ActiveRecord::Migration[6.1]
  def change
    create_table :post_commentents do |t|
      t.text :comment, null: false
      t.timestamps
    end
  end
end
