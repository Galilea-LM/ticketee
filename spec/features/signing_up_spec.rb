# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'Users can sing up' do
  scenario 'when providing valid details' do
    visit '/'
    click_link 'Sing up'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'iser_password', with: 'password'
    fill_in 'password confirmation', with: 'password'
    click_button 'Sing up'
    expect(page).to have_content('You have signed up successfully.')
  end
end
