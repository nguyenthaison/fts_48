require "rails_helper"

RSpec.describe ExamsController, type: :controller do
  let(:exam) {FactoryGirl.create :exam}
  let(:user) {FactoryGirl.create :user}
  let(:subject) {FactoryGirl.create :subject}

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return user
  end

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(assigns(:exam)).to be_a_new Exam
      expect(response).to render_template("exams/index")
      expect(response).to render_template("layouts/application")
    end
  end

end
