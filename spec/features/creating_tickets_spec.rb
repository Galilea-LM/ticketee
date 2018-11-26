require "rails_helper"
RSpec.feature "Users can create new tickets" do
    before do
        project= FactoryBot.create(:projects, name: "Internet Explorer")
        visit project_path(project)
        click_link "New Ticket"
    end
    scenario "wit valid attributes" do
        fill_in "Name", with: "Non-standars compliance"
        fill_in "Description", with: "My oages are ugly!"
        clic_button "CReate ticket"
        expect(page).to have_content "Ticket has been created."
    end

    scenario "when providing invalid attibutes" do
        clic_button "Create Ticket"

        expect(page).to have_content "Ticket has no been created."
        expect(page).to have_contect "Name can;t be blank"
        expect(page).to have_content "Description can't be blank"
    end

    scenario "with an invalid description" do
        fill_in "Name", with: "Non-standards compliance"
        fill_in "Description", with: "It sucks"
        click_button "Create Ticket"
        expect(page).to have_content "Ticket has not been created."
        expect(page).to have_content "Description is too short"
    end
end
