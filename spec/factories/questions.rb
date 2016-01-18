FactoryGirl.define do
  factory :question do
    subject {FactoryGirl.create :subject}
    user {FactoryGirl.create :user}
    content Faker::Lorem.sentence
    answers [FactoryGirl.build(:answer)]
    status :waitting
    question_type [:single, :multiple, :text].sample
  end

  factory :question_single do
    subject {FactoryGirl.create :subject}
    user {FactoryGirl.create :user}
    content Faker::Lorem.sentence
    answers [FactoryGirl.build(:answer)]
    status :waitting
    question_type :single
  end

  factory :question_text do
    subject {FactoryGirl.create :subject}
    user {FactoryGirl.create :user}
    content Faker::Lorem.sentence
    answers [FactoryGirl.build(:answer)]
    status :waitting
    question_type :text
  end

  factory :question_multiple do
    subject {FactoryGirl.create :subject}
    user {FactoryGirl.create :user}
    content Faker::Lorem.sentence
    answers [FactoryGirl.build(:answer)]
    status :waitting
    question_type :multiple
  end

  factory :question_fail do
    user {FactoryGirl.create :user}
    subject {FactoryGirl.create :subject}
    status :accept
  end
end
