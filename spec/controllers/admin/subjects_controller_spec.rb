require "rails_helper"

RSpec.describe Admin::SubjectsController, type: :controller do
  let!(:subject){FactoryGirl.create :subject}
  let!(:admin){FactoryGirl.create :admin}
  before{sign_in admin}
  after{Subject.destroy_all}

  describe "GET index" do
    before{get :index}
    it{expect(assigns(:subjects)).to eq [subject]}
    it{expect(response).to render_template :index}
    it{expect(response.status).to eq 200}
  end

  describe "GET new" do
    before{get :new}
    it{expect(assigns(:subject)).to be_a_new Subject}
    it{expect(response).to render_template :new}
    it{expect(response.status).to eq 200}
  end

  describe "POST create" do
    before do
      Subject.destroy_all
      post :create, subject: subject_params
    end

    context "case success" do
      let(:subject_params){FactoryGirl.attributes_for(:subject)}
      it{expect(Subject.count).to eq 1}
      it{is_expected.to be_a Subject}
      it{expect(response).to redirect_to [:admin, :subjects]}
    end

    context "case failed" do
      let(:subject_params){FactoryGirl.attributes_for(:invalid_subject)}
      it{expect(Subject.count).to eq 0}
      it{is_expected.to be_a Subject}
      it{expect(flash.now[:danger]).to be_present}
      it{expect(response).to render_template :new}
    end
  end

  describe "GET edit" do
    before{get :edit, id: subject}
    it{expect(assigns(:subject)).to eq subject}
    it{is_expected.to be_a Subject}
    it{expect(response).to render_template :edit}
    it{expect(response.status).to eq 200}
  end

  describe "GET show" do
    before{get :show, id: subject}
    it{expect(assigns(:subject)).to eq subject}
    it{is_expected.to be_a Subject}
    it{expect(response).to render_template :show}
    it{expect(response.status).to eq 200}
  end

  describe "DELETE destroy" do
    before{delete :destroy, id: subject}

    it{expect(flash[:success]).to be_present}
    it{expect(response).to redirect_to [:admin, :subjects]}
  end

end

