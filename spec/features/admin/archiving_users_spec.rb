require "rails_helper"
RSpec.feature "An admin can archive users" do
  let(:admin_user){FactoryBot.create(:user, :admin)}
  let(:user){Factorybot.create(:user)}
  before do
    login_as(admin_user)
  end
  scenario "successfully" do
    visit admin_user_path(user)
    click_link "Archive User"

    expect(page).to have_content "User has been archived"
    expect(page).not_to have_content user.email
  end

end
