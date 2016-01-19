require "rails_helper"

RSpec.describe Admin::ActivitiesController, type: :controller do
  let!(:admin){FactoryGirl.create :admin}
  let!(:activity){FactoryGirl.create :activity}
  before {sign_in admin}

  describe "GET index" do
    before{get :index}
    it{expect(response).to render_template :index}
    it{expect(response.status).to eq 200}
    it {expect(response).to render_template("layouts/application")}
  end
end
