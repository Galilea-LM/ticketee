# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'Users can create new tickets' do
  let(:state){ FactoryBot.create :state, name: "New", default: true }
  let(:user) { FactoryBot.create(:user) }
  before do
    login_as(user)
    project = FactoryBot.create(:projects, name: 'Internet Explorer')
    assign_role!(user, :viewer, project)
    visit project_path(project)
    click_link 'New Ticket'
  end
  scenario 'wit valid attributes' do
    fill_in 'Name', with: 'Non-standars compliance'
    fill_in 'Description', with: 'My pages are ugly!'
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket has been created.'
    expect(page).to have_content 'State: New'
    within('#ticket') do
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario 'when providing invalid attibutes' do
    click_button 'Create Ticket'

    expect(page).to have_content 'Ticket has not been created.'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario 'with an invalid description' do
    fill_in 'Name', with: 'Non-standards compliance'
    fill_in 'Description', with: 'It sucks'
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket has not been created.'
    expect(page).to have_content 'Description is too short'
  end
  scenario "whit associated tags" do 
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    fill_in "Tags", with: "browser visual"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
    within("#ticket #tags") do 
      expect(page).to have_content "browser"
      expect(page).to have_content "visual"
    end
  end
end
