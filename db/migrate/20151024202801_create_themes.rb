class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.string :slug
      t.references :blogger, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
