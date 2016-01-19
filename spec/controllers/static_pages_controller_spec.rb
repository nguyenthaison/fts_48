require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do

  describe "GET home" do
    before {get :home}
    it "call home page" do
      expect(response).to render_template("layouts/application")
      expect(response).to render_template("static_pages/home")
    end
    it{expect(response.status).to eq 200}
  end

  describe "GET about" do
    before {get :about}
    it "call about page" do
      expect(response).to render_template("layouts/application")
      expect(response).to render_template("static_pages/about")
    end
    it{expect(response.status).to eq 200}
  end

end
