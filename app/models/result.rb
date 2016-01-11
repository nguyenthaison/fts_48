class Result < ActiveRecord::Base
  belongs_to :answer
  belongs_to :exam
  belongs_to :question

  scope :correct_answer, ->{joins(:answer).where answers: {is_correct: 1}}
end
