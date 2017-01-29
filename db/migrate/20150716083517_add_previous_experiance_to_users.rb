class AddPreviousExperianceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :previous_experiance, :string
  end
end
