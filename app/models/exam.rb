class Exam < ActiveRecord::Base
  enum status: [:start,:testing, :unchecked,:checked]

  belongs_to :subject
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results

  before_create :init_exam

  def change_status_after_start
    if self.start?
      self.status = :testing
      self.save
    end
  end

  private
  def init_exam
    @questions = self.subject.questions.accept.order("RANDOM()").
      limit(Settings.exam.number_of_question)
    @questions.each do |question|
      self.results.build question_id: question.id
    end
  end

end
