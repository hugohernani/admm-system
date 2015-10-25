class CreateBloggers < ActiveRecord::Migration
  def change
    create_table :bloggers do |t|
      t.integer :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
