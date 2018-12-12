require "rails_helper"
RSpec.feature "Users can only see the appropiate links" do
    let(:user){FactoryBot.create(:user)}
    let(:admin){FactoryBot.create(:user, :admin)}

    context "anonymus users" do
        scenario "cannot see the New Project link" do
            visit "/"
            expect(page).not_to have_link "New Project"
        end
    end
    context "non-admin users (project viewers)" do
      before do
        login_as(user)
        assign_role!(user, :viewer, project)
      end
    end

    context "regular users" do
        before {login_as(user)}
        scenario "cannot see the New Project link" do
            visit "/"
            expect(page).not_to have_link "New Project"
        end
    end
    context "admin users" do
        before {login_as(admin)}
        scenario "can see the New Project link" do
            visit "/"
            expect(page).to have_link "New Project"
        end
    end
    context "admin users" do
        before {login_as(admin)}
        scenario "can see the New Project link" do
            visit project_path(project)
            expect(page).to have_link "New Project"
        end
    end
    context "regular users" do
        before {login_as(user)}
        scenario "cannot see the Delete Project link" do
            visit project_path(project)
            expect(page).not_to have_link "Delete Project"
        end
    end

end
