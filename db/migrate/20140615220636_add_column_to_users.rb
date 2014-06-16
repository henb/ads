class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :myads, :user_id, :integer
  end
end
