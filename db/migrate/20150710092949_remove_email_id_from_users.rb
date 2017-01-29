class RemoveEmailIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :emailid, :string
  end
end
