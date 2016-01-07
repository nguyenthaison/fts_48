class Exam < ActiveRecord::Base
  enum status: [:start,:unchecked,:checked]

  belongs_to :subject
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  before_create :init_exam

  private
  def init_exam
    @questions = self.subject.questions.accept.order("RANDOM()").
      limit(Settings.exam.number_of_question)
    @questions.each do |question|
      self.results.build question_id: question.id
    end
  end

end
