require "rails_helper"
RSpec.feature "Users can view tickets" do
    before do
        author = FactoryBot.create(:user)
        sublime = FactoryBot.create(:project, name: "Sublime Text 3")
        FactoryBot.create(:ticket, project: sublime, author: author, name: "Make it shiny!", description: "Gradientes! Starbursts! Oh my!")
        ie = FactoryBot.create(:ticket, project: ie, author: author, name: "Stardards compliance", description: "Isn't a joke.")
        visit "/"
    end
   
    scenario "for a given project" do 
        click_link "Sublime Text 3"
        expect(page).to have_content "Make it shiny!"
        expect(page).to_not have_content "Stardards compliance"

        click_link "Make it shiny!"
        within ("#ticket h2") do 
            expect(page).to have_content "Make it shiny!"
        end

        expect(page).to have_content "Gradientes! Starbursts! Oh my!"
    end
end