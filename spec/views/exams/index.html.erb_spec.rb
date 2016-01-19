require "rails_helper"

describe "exams/index.html.erb" do
  subject {rendered}
  let(:user) {create :user}
  let(:subject) {create :subject}
  let(:exam) {create :exam, subject: subject, user: user}

  before do
    sign_in user
    assign :exam, exam
    assign :exams, user.exams
    assign :subjects, [subject]
    render
  end

  it do
    expect(rendered).to have_content "Examination List"
    expect(rendered).to have_content exam.id
    expect(rendered).to have_content exam.duration
    expect(rendered).to have_content exam.number_of_question
    expect(rendered).to have_content exam.subject.name
    expect(rendered).to have_content exam.status
  end

  it do
    expect(rendered).to have_selector "form" do |form|
      form.is_epected.to have_selector "select", name: "subject_id"
      form.is_epected.to have_selector "input", name: "duration"
      form.is_epected.to have_selector "input", name: "status"
      form.is_epected.to have_selector "input", type: "submit"
    end
  end

  describe "create exam" do
    scenario "can edit question success" do
      expect(rendered).to have_button("Create Exam")
    end
  end

end
