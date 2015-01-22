require 'spec_helper'

describe User do
	let(:valid_attributes) {
			{
				first_name: "Nick",
				last_name: "Ross",
				email: "mx5433@gmail.com",
				password: "password1234",
				password_confirmation: "password1234"

			}
		}

	context "relationships" do
		it { should have_many(:todo_lists)}
	end

	context "validations" do
		let(:user) { User.new(valid_attributes) }
		
		before do
			User.create(valid_attributes)
		end

		it "requires an email" do
			expect(user).to validate_presence_of(:email)
		end 

		it "requires a unique email" do
			expect(user).to validate_uniqueness_of(:email)
		end

		it "requires a unique email(case insensitive)" do
			user.email = "MX5433@GMAIL.COM"
			expect(user).to validate_uniqueness_of(:email)
		end

		it "requires the email address to look like an email" do
			user.email = "mx5433"
			expect(user).to_not be_valid
		end
	
	end

	describe "#downcase_email" do
		it "makes the email attribute lower case" do
			user = User.new(valid_attributes.merge(email: "MX5433@GMAIL.COM"))
			#user.downcase_email
			#expect(user.email).to eq("mx5433@gmail.com")
			expect{ user.downcase_email }.to change{ user.email }.
				from("MX5433@GMAIL.COM").
				to("mx5433@gmail.com")
		end

		it "downcases an email before saving" do
			user = User.new(valid_attributes)
			user.email = "MX5433@GMAIL.COM"
			expect(user.save).to be_truthy
			expect(user.email).to eq("mx5433@gmail.com")
		end
	end

	describe "#generate_password_reset_token!" do
		let(:user) {create(:user)}

		it "changes the password_reset_token attribute" do
			expect{ user.generate_password_reset_token! }.to change{user.password_reset_token}
		end

		it "calls SecureRandom.urlsafe_base64 to generate the password_reset_token" do
			expect(SecureRandom).to receive(:urlsafe_base64)
			user.generate_password_reset_token!
		end
	end
end
