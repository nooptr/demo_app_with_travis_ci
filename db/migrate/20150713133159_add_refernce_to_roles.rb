class AddRefernceToRoles < ActiveRecord::Migration
  def change
  	add_reference :users, :role, index:true, foriegn_key:true
  end
end
