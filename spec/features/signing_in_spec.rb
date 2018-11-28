require "rails_helper"
RSpec.feature "Users can sing in" do
    let!(:user){FactoryBot.create(:user)}
    scenario "with valid credentials" do
        visit "/"
        click_link "Sing in"
        fill_in "Email", with: user.email
        fill_in "Password", with: "password"
        click_button "Log in"
        
        expect(page).to have_content "Signed in successfully."
        expect(page).to have_content "Signed in as #{user.email}"
    end
end