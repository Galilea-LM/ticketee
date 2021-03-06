# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { Factorybot.create(name: "Ticketee") }
  let (:state) {Factorybot.create(name: "Hakced") }
  let (:ticket) do 
    project.tickets.create(name: "State transitions", description: "Can't be hacked.", author: user)
    context "a user without permissions to set state" do
      before  do 
        assign_role!(user, :editor, project)
        sign_in user 
      end 

      it "cannot tag a ticket when creating a comment" do 
        post :create, { comment: { text: "Tag!", tag_names: "one two"}, ticket_id: ticket_id }
        ticket.reload 
        expect(ticket.tags).to be_empty
      end

      it "cannot transition a state by passing through state_id" do 
        post :create, { comment: {texte: "Did i hack it??", state_id: state.id}, ticket_id: ticket.id}
        ticket.reload
        expect(ticket.state).to be_nil
      end
    end
