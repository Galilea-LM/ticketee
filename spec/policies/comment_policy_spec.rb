# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CommentPolicy do
  context 'permissions' do
    subject { CommentPolicy.new(user, comment) }
    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project) }
    let(:ticket) { FactoryBot.create(:ticket, project: project) }
    let(:comment){FactoryBot.create(:comment, ticket: ticket)}
    context 'for anonymous users' do
      let(:user) { nil }
      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end
    context 'for viewers of the  project' do
      before { assign_role!(user, :viewer,  project) }
      it { should permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }
    end
    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should_not permit_action :destroy }
    end
    context 'for managers of other projects' do
      before { assign_role!(:user, :manager, FactoryBot.create(:project)) }
      it { should  permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should  permit_action :destroy }
    end
    context 'for dministrators' do
      let(:user) { FactoryBot.create :user, :admin }
      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }
    end
  end
end
