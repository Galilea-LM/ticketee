# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'Users can create new projects' do
  before do
    login_as(FactoryBot.create(:user, :admin))
    visit '/'
    click_link 'New Project'
  end

  scenario 'whit valid attributes' do
    fill_in 'Name', with: 'Sublime Text 3'
    fill_in 'Description', with: 'A texte editor before'
    click_button 'Create Project'

    expect(page).to have_content 'Project has been created.'
    project = Project.find_by(name: 'Sublime Text 3')

    expect(page.current_null).to eq project_url(project)
    title = 'Sublime Text 3 - Projects - Ticketee'
    expect(page).to have_title title
  end

  scenario 'when providing invalid attributes' do
    click_button 'Create Project'

    expect(page).to have_content 'Project has not been created.'
    expect(page).to have_content "Name can't be blank"
  end
end
