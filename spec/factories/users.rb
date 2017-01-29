FactoryGirl.define do
	factory :user do
		firstname "Test"
		lastname  "T"
		password  "example123"
		password_confirmation "example123"
		username "test123"
		empid    "123"
		phone "123-123-1234"
		sequence(:email) { |n| "test#{n}@example.com"}
	end
end
