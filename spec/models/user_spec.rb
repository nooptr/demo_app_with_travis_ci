require "rails_helper"

RSpec.describe User, :type => :model do 
	describe "Associations" do
		it { expect(subject).to belong_to(:designation) }
    it { expect(subject).to belong_to(:role) }
	end

	describe "Validations" do
    it { is_expected.to validate_presence_of :firstname  }
    it { is_expected.to validate_presence_of(:lastname) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation).on(:create) }
  	it { is_expected.to validate_presence_of(:username) }
  	it { expect(subject).to validate_uniqueness_of(:username) }
  	it { expect(subject).to validate_presence_of(:empid) }
  	it { expect(subject).to allow_value('Abc', 'abc').for(:firstname).with_message('only allow letters')}
  	it { expect(subject).not_to allow_value('abc223', 'A@', '11@#$').for(:firstname).with_message('only allow letters') }
    it { expect(subject).to allow_value('Abc', 'abc').for(:lastname).with_message('only allow letters')}
  	it { expect(subject).not_to allow_value('abc223', 'A@', '11@#$').for(:lastname).with_message('only allow letters') }
    it { expect(subject).to allow_value('abc12', 'abc_1', '12121').for(:username).with_message('only allow letters,numbers,underscore and hyphen')}
  	it { expect(subject).not_to allow_value('abc@', 'A@', '11@#$', 'ABC').for(:username).with_message('only allow letters,numbers,underscore and hyphen') }
    it { expect(subject).to allow_value('123-123-1234', '123-333-4444').for(:phone).with_message('only allow numbers')}
  	it { expect(subject).not_to allow_value('abc@', '211321321331323', '2653281738527725', 'ABC').for(:phone).with_message('only allow numbers') }
  end

  describe "Methods" do
  	describe "set default role" do 
  		before(:each) do 
  			@user_role = FactoryGirl.create(:role, name: "user")
  			@admin_role = FactoryGirl.create(:role, name: "admin")
  		end

  		context "when no role passed" do 
  			it "set default user role" do 
  				user = FactoryGirl.create(:user)
  				expect(user.role_id).to eq @user_role.id
  			end
  		end

  		context "when role is passed" do 
  			it "set passed role" do 
  				user = FactoryGirl.create(:user,role_id: @admin_role.id )
  				expect(user.role_id).to eq @admin_role.id
  			end
  		end
  	end

  	it "calculate previous experiance" do 
  		user = FactoryGirl.create(:user, previous_experiance_year: 1, previous_experiance_month: 1)
  	  expect(user.previous_experiance).to eq "1.1"
  	end

  	context "reset status" do 
      let!(:user) { FactoryGirl.create(:user, locked_at: Date.today, reason: "invalied login", deactivated_date: Date.today, locked: "locked", failed_attempts: 5) }

  		it "set locked_at to nil" do 
  			expect { user.reset_status }.to change(user, :locked_at).from(Date.today).to(nil)
  		end

  		it "set failed_attempts to 0" do 
  			expect { user.reset_status }.to change(user, :failed_attempts).from(5).to(0)
  		end

      it "set locked to active" do 
        expect { user.reset_status }.to change(user, :locked).from("locked").to("active")
      end
  	end

  	it "calculate total experiance" do
  		user = FactoryGirl.create(:user, :previous_experiance => 2, :doj => (Date.today - 3.months))
  	  expect(user.calculate_total_experiance).to eq "2.2"
  	end
  end
end
