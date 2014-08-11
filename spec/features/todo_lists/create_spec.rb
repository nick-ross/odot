require 'spec_helper'


describe "Creating todo lists" do
	it "redirects to the todo list index page on success" do 
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")


		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"


		expect(page).to have_content("My todo list")
	end

	it "displays an error when todo list has no title" do 
		expect(Todo_list.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")


		fill_in "Title", with: ""
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"


		expect(page).to have_content("error")
		expect(Todo_list.count).to eq(0)


		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end

		it "displays an error when todo has a title less than 3 characters" do 
		expect(Todo_list.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")


		fill_in "Title", with: "Hi"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create Todo list"


		expect(page).to have_content("error")
		expect(Todo_list.count).to eq(0)


		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end
end