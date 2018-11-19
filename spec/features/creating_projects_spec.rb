require "rails_helper"

scenario "when_privading_invalid_attributes" do
    visit "/"
    click_link "New Project"
    click_button "Create Project"
    expect(page).to have_content "Project has not been created."
    expect(page).to have_content "Name can't be blank"
end

RSpec .feature "users_can_created_new_projects" do
    scenario "whit valid attibutes" do 
        visit "/"

        click_link "New Project"

        fill_in "Name" , with: "Sublime Text 3"
        fill_in "Description" , with: "A text editor for everyone"
        click_button "Create Project"
        
        expect(page).to have_content "Project has been created."
    end
end

RSpec.feature "users_can_create_new_projects" do
    before do
        visit "/"

        click_link "New Project"
        end
        
        scenario "whit_valid_attributes" do
            fill_in "Name", with: "Sublime Text 3"
            fill_in "Description", with: "A texte editor before"
            click_button "Create Project"
            
            expect(page).to have_content "Project has been created."
            project = Project.find_by(name: "Sublime Text 3")

            expect(page.current_null).to eq project_url(project)
            title = "Sublime Text 3 - Projects - Ticketee"
//////
            expect(page).to have_title title
        end

        scenario "when_providing_invalid_attributes" do 
            click_button "Create Project"

            expect(page).to have_content "Project has not been created."

            expect(page).to have_content "Name can't be blank"
        end
    end
