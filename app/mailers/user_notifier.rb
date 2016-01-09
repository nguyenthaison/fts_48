class UserNotifier < ApplicationMailer
  def send_exam_result exam
    @exam = exam
    @user = exam.user
    mail to: @user.email, subject: t("mailer.subject_title")
  end

end
