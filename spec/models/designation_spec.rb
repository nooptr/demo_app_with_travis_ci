require "rails_helper"

RSpec.describe Designation, :type => :model do 
	describe "Associations" do
		it { expect(subject).to have_many(:users) }
	end

	describe "Methods" do
  	it "return designation list" do
  		designation1 = FactoryGirl.create(:designation, name: "Trainies")
			designation2 = FactoryGirl.create(:designation, name: "Trainer")
  		expect(Designation.designation_list).to eq [[designation1.id, designation1.name], [designation2.id, designation2.name]]
  	end
  end
end
