require "spec_helper"

describe "Logging In" do
	it "logs the user in and goes to the todo lists" do
		User.create(first_name: "Nick", last_name: "Ross", email: "mx5433@gmail.com", password: "password1234", password_confirmation: "password1234")
		visit new_user_session_path
		click_link "Sign In"
		fill_in "Email Address", with: "mx5433@gmail.com"
		fill_in "Password", with: "password1234"
		click_button "Log In"
		
		expect(page).to have_content("Todo lists")
		expect(page).to have_content("Thanks for logging in!")
	end

	it "displays the email address in the event of a failed login" do
		visit new_user_session_path
		fill_in "Email Address", with: "mx5433@gmail.com"
		fill_in "Password", with: "incorrect"
		click_button "Log In"

		expect(page).to have_content("Please check your email and password")
		expect(page).to have_field("Email Address", with: "mx5433@gmail.com")
	end
end