class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :description
      t.text :body
      t.string :slug
      t.integer :status,      default: 0
      t.boolean :can_comment, default: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
