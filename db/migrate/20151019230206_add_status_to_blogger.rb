class AddStatusToBlogger < ActiveRecord::Migration
  def change
    add_column :bloggers, :status, :integer
  end
end
