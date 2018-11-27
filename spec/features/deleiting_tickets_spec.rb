require "rails_helper"
RSpec.feature "Users can delete tickets" do
    let(:project){FactoryBot.create(:project)}
    let(:ticket){FactoryBot.create(:ticket, project: project)}
    before do
        visit project_ticket_path(project,ticket)
    end

    scenario "successfully" do
        click_link "Dlete Ticket"
        expec(page).to have_content "Ticket has been deleted."
        expec(page.current_url).to eq project_url(project)
    end
end
