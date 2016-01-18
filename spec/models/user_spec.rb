require "rails_helper"
require "cancan/matchers"

RSpec.describe User, type: :model do

  let(:user){FactoryGirl.create :user}

  describe "association" do
    it{expect(user).to have_many(:exams)}
    it{expect(user).to have_many(:questions)}
  end

  describe "create in valid" do
    it{expect(user.errors).to be_empty}
    it{expect(user.password.length).to be >= 8}
    it{expect(user.email.length).to be <= 255}
    it{expect(user.name.length).to be <= 50}
    it{expect(user).to validate_uniqueness_of(:chatwork_id)}
  end

  describe "when login system" do
    context "admin" do
      let(:user){FactoryGirl.create :admin}
      subject(:ability){Ability.new(user)}
      it{is_expected.to be_able_to :manage, Subject}
      it{is_expected.to be_able_to :manage, User}
      it{is_expected.to be_able_to :manage, Question}
      it{is_expected.to be_able_to :manage, Exam}
    end

    context "normal" do
      let(:user){FactoryGirl.create :user}
      subject(:ability){Ability.new(user)}
      it{should_not be_able_to :create, Subject}
      it{should be_able_to :create, Question}
      it{should_not be_able_to :delete, User}
      it{should_not be_able_to :manage, Exam}
    end
  end

end

