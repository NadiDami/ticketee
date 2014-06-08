require 'spec_helper'

feature 'Deleting tags' do
  let!(:user) { create(:user)}
  let!(:project) { create(:project)}
  let!(:ticket) do
    create(:ticket, 
           :project => project,
           :tag_names => 'this-tag-must-die',
           :user => user)
  end

  before do
    sign_in_as!(user)
    define_permission!(user, "view", project)
    define_permission!(user, "tag", project)
    visit '/'
    click_link project.name
    click_link ticket.title
  end

  scenario 'Deleting a tag', :js => true do
    click_link 'delete-this-tag-must-die'
    within('#ticket #tags') do
      expect(page).not_to have_content('this-tag-must-die')
    end
  end
end



