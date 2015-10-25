class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.text :body
      t.string :slug
      t.integer :status,      default: 0
      t.boolean :comment_allowed, default: true

      t.timestamps null: false
    end
  end
end
