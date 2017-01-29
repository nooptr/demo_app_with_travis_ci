class Role < ActiveRecord::Base
	has_many :users

	def self.user_role
		Role.find_by_name("user")
	end

  def self.role_list
    pluck(:id,:name)
  end
end
