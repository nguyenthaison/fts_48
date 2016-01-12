desc "send digest email"
task statistic_exam_email: :environment do
  Exam.send_statistic_exam_email
end
