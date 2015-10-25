class AddReferencesToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :theme, index: true, foreign_key: true
  end
end
