require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  let!(:admin){FactoryGirl.create :admin}
  let!(:user) {FactoryGirl.create :user}

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return user
  end

  describe "GET #index" do
    before {get :index}
    it {expect(response.status).to eq 302}
    it {expect(response).to redirect_to root_url}
  end

  describe "GET show" do
    before {get :show, id: user}
    it {expect(response.status).to eq 200}
    it {expect(response).to render_template :show}
  end

  describe "DELETE destroy" do
    before {delete :destroy, id: user}
    it {expect(response.status).to eq 302}
    it {expect(response).to redirect_to root_url}
    it {expect(flash[:alert]).to be_present}
  end
end
