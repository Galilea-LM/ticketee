require "rails_helper"
RSpec.feature "Users_can_view_projects" do
    scenario "whit the project details" do
        project = FactoryGirl.create(:project, name: "Sublime Text 3")
        visit "/"
        click_link(page.current_url).to eq project_url(project)
    end
end    