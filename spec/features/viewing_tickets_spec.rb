require 'spec_helper'

feature "Viewing tickets" do
  before do
    textmate_2 = FactoryGirl.create(:project, name: "TextMate 2")
    
    user = FactoryGirl.create(:user)
    sign_in_as! user
    define_permission! user, "view", textmate_2

    FactoryGirl.create(:ticket, project: textmate_2, user: user, title: "Make it shiny!", description: "Gradients! Starbursts! Oh my!")

    internet_explorer = FactoryGirl.create(:project, name: "Internet Explorer")
    define_permission! user, "view", internet_explorer
    
    FactoryGirl.create(:ticket, project: internet_explorer, title: "Standards compliance", description: "Isn't a joke.")

    visit '/'
  end

  scenario "viewing tickets for a given project" do
    click_link "TextMate 2"

    expect(page).to have_content("Make it shiny!")
    expect(page).to_not have_content("Standards compliance")

    click_link "Make it shiny!"
    within("#ticket h2") do
      expect(page).to have_content("Make it shiny!")
    end

    expect(page).to have_content("Gradients! Starbursts! Oh my!")
  end

end