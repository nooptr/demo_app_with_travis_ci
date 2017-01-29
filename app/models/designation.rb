class Designation < ActiveRecord::Base
	has_many :users

	def self.designation_list
    pluck(:id,:name)
  end
end
