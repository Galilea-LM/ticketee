# frozen_string_literal: true

require 'rails_helper'
RSpec.feature 'Users can only see the appropiate links' do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:ticket) do FactoryBot.create(:ticket, project: project, author: user) 
  end

  context 'anonymus users' do
    scenario 'cannot see the New Project link' do
      visit '/'
      expect(page).not_to have_link 'New Project'
    end
  end

  context 'non-admin users (project viewers)' do
    before do
      login_as(user)
      assign_role!(user, :viewer, project)
    end
    scenario 'cannot see the Edit Project link' do
      visit project_path(project)
      expect(page).not_to have_link 'Edit Project'
    end
    scenario 'cannot see the New Ticket link' do
      visit project_path(project)
      expect(page).not_to have_link 'New Ticket'
    end
    scenario 'cannot see the Edit Ticket link' do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link 'Edit Ticket'
    end
  end

  context 'regular users' do
    before { login_as(user) }
    scenario 'cannot see the New Project link' do
      visit '/'
      expect(page).not_to have_link 'New Project'
    end
    scenario 'cannot see the Delete Project link' do
      visit project_path(project)
      expect(page).not_to have_link 'Delete Project'
    end
  end

  context 'admin users' do
    before { login_as(admin) }
    scenario 'can see the New Project link' do
      visit '/'
      expect(page).to have_link 'New Project'
    end
    scenario 'can see the Edit Project link' do
      visit project_path(project)
      expect(page).to have_link 'Edit Project'
    end
    scenario 'can see the New Ticket link' do
      visit project_path(project)
      expect(page).to have_link 'New Ticket'
    end
    scenario 'can see the Edit Ticket link' do
      visit project_ticket_path(project, ticket)
      expect(page).to have_link 'Edit Ticket'
    end
  end
end
