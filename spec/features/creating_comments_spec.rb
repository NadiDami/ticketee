require 'spec_helper'

feature 'Creating comments' do
  let!(:user) { create(:user) }
  let!(:project) { create(:project) }
  let!(:ticket) { create(:ticket, project: project, user: user) }

  before do
    define_permission!(user, "view", project)
    define_permission!(user, "tag", project)
    create(:state, name: "Open")
    sign_in_as! user
    visit '/'
    click_link project.name
  end

  scenario 'Creating a comment' do
    click_link ticket.title
    fill_in 'Text', with: 'Added a comment!'
    click_button 'Create Comment'
    page.should have_content("Comment has been created.")
    within("#comments") do
      page.should have_content("Added a comment!")
    end
  end

  scenario "Creating an invalid comment" do
    click_link ticket.title
    click_button "Create Comment"
    page.should have_content("Comment has not been created.")
    page.should have_content("Text can't be blank") 
  end

  
  scenario "Changing a ticket's state" do
    define_permission!(user, "change states", project)
    click_link ticket.title
    fill_in 'Text', with: "This is a real issue"
    select "Open", from: "State"
    click_button 'Create Comment'
    page.should have_content "Comment has been created."

    within("#ticket .state", match: :first ) do
      page.should have_content "Open"
    end

    within("#comments") do
      page.should have_content "State: Open"
    end
  end

  scenario "A user without permission cannot change the state" do
    click_link ticket.title
    find_element = lambda { find "#comment_state_id" }
    error_message = "Expected not to see #comment_state_id, but did."
    find_element.should(raise_error(Capybara::ElementNotFound), error_message)
  end

  scenario "Adding a tag to a ticket" do
    click_link ticket.title
    within('#ticket #tags') do
      expect(page).not_to have_content('bug')
    end

    fill_in 'Text', with: 'Adding the bug tag'
    fill_in 'Tags', with: 'bug'
    click_button 'Create Comment'

    within('#ticket #tags') do
      expect(page).to have_content('bug')
    end
  end

end
