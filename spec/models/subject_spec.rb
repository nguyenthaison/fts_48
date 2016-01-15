require "rails_helper"

RSpec.describe Subject, type: :model do
  let!(:subject){FactoryGirl.create :subject}

  describe "create in valid" do
    it{expect(subject.errors).to be_empty}
    it{expect(subject.name.length).to be <= 100}
  end

  describe "association" do
    it{is_expected.to have_many(:exams)}
    it{expect(subject).to have_many(:questions)}
  end

end


