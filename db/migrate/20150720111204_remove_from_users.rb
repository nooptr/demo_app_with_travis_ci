class RemoveFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :loginid
  end
end
