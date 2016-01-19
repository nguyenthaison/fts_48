require "rails_helper"

describe "questions/edit.html.erb" do
  subject {rendered}
  let(:user) {create :user}
  let(:question) {create :question}
  let(:subject) {create :subject}

  before do
    sign_in user
    assign :question, question
    assign :subjects, [subject]
    render
  end

  describe "edit question" do
    let!(:question) {FactoryGirl.create :question}
    scenario "edit question" do
      expect(rendered).to have_button("Suggest")
    end
  end
end
