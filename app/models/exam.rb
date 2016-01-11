class Exam < ActiveRecord::Base
  enum status: [:start,:testing, :unchecked,:checked]

  belongs_to :subject
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results

  before_create :init_exam

  def change_status_after_start
    if self.start? || self.testing?
      self.status = :testing
      self.started_at = Time.zone.now.to_i
      self.calculate_time
      self.save
    end
  end

  def calculate_time
    self.spent_time = Time.zone.now.to_i - self.started_at
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
