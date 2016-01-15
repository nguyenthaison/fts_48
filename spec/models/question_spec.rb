require "rails_helper"

RSpec.describe Question, type: :model do

  describe "association" do
    let(:question){FactoryGirl.create :question}
    it{expect(question).to have_many(:answers)}
    it{expect(question).to have_many(:results)}
    it{expect(question).to have_many(:exams).through(:results)}
    it{expect(question).to belong_to(:subject)}
    it{expect(question).to belong_to(:user)}
  end

  describe "#question" do
    let(:question){FactoryGirl.build :question}
    before {question.content = ""}
    it {is_expected.to validate_presence_of(:content)}
  end
end
