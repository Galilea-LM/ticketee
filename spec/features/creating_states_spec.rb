# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'Users can create new states for tickets' do
  before do
    login_as(FactoryBot.create(:user, :admin))
    visit admin_root_path
    click_link "States"
    click_link "New State"
  end

  scenario 'whit valid details' do
    fill_in 'Name', with: "Won't Fix"
    fill_in 'Color', with: 'Orange'
    click_button 'Create state'

    expect(page).to have_content 'State has been created.'
  end

  scenario 'when providing invalid details' do
    click_button 'Create State'

    expect(page).to have_content 'State has not been created.'
    expect(page).to have_content "Name can't be blank"
  end
end
