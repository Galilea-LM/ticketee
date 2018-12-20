# frozen_string_literal: true

require 'rails_helper'
require 'support/authorization_helpers'
RSpec.feature 'Users can view projects' do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, name: 'Sublime Text 3') }
  before do
    login_as(user)
    assign_role!(:user, :viewer, project)
  end
  scenario 'unlles they do not have permission' do
    FactoryBot.create(:project, name: 'Hidden')
    visit '/'
    expect(page).not_to have_content 'Hidden'
  end

  scenario 'whit the project details' do
    visit '/'
    click_link 'Sublime Text 3'
    expect(page.current_url).to eq project_url(project)
  end
end
