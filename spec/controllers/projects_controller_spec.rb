require 'rails_helper'
RSpec.describe ProjectsController, type: :controller do
    it "handles a missing project correctly" do
        get :show, id: "not-here"

        expect(response).to redirect_to(projects_path)
        message= "The project tou were looking for couls not be found."
        expect(flash[:alert]).to eq message
    end 
end
