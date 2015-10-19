class AddSlugToBloggers < ActiveRecord::Migration
  def change
    add_column :bloggers, :slug, :string, index: true
  end
end
