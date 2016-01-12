class Exam < ActiveRecord::Base
  TIME_PER_EXAM = 28800

  enum status: [:start,:testing, :unchecked,:checked]

  belongs_to :subject
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results

  before_create :init_exam
  after_update :send_exam_message
  after_create :delay_exam_create

  def change_status_after_start
    if self.start?
      self.status = :testing
      self.started_at = Time.zone.now.to_i
      self.calculate_time
      self.save
    end
  end

  def calculate_time
    self.spent_time = Time.zone.now.to_i - self.started_at
  end

  def time_remain
    self.duration*60 - self.spent_time
  end

  def send_exam_message
    HardWorker.perform_async self.id if self.checked?
  end

  def check_time_exam
    if (Time.zone.now - self.created_at).to_i >= Exam::TIME_PER_EXAM
      return true
    else
      return false
    end
  end

  def delay_exam_create
    if check_time_exam && self.start?
      UserNotifier.delay_exam_when_create(self).deliver_now
    end
  end
  handle_asynchronously :delay_exam_create, run_at: Proc.new { 8.hours.from_now }

  private
  def init_exam
    self.spent_time = 0
    @questions = self.subject.questions.accept.order("RANDOM()").
      limit(Settings.exam.number_of_question)
    @questions.each do |question|
      self.results.build question_id: question.id
    end
  end

end
