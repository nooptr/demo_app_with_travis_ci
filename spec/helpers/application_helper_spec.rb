require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#error_list" do
    it "returns list of errors" do
    	user = FactoryGirl.build(:user, firstname: nil)
			user.valid?
      expect(helper.error_list user,:firstname).to eq "can't be blank,only allow letters"
    end
  end
end