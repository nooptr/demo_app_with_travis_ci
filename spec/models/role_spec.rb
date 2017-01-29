require "rails_helper"

RSpec.describe Role, :type => :model do 
	describe "Associations" do
		it { expect(subject).to have_many(:users) }
	end

	describe "Methods" do
		before(:each) do 
			@user_role = FactoryGirl.create(:role, name: "user")
			@admin_role = FactoryGirl.create(:role, name: "admin")
		end

  	it "return user role" do 
			expect(Role.user_role).to eq @user_role
  	end

  	it "return role list" do
  		expect(Role.role_list).to eq [[@user_role.id, @user_role.name], [@admin_role.id, @admin_role.name]]
  	end
  end
end
