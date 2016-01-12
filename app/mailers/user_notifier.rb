class UserNotifier < ApplicationMailer
  def send_exam_result exam
    @exam = exam
    @user = exam.user
    mail to: @user.email, subject: t("mailer.subject_title")
  end

  def send_when_create_subject user, subject
    @user = user
    @subject = subject
    mail to: @user.email, subject: t("subject_mailer.title")
  end

  def delay_exam_when_create exam
    @user = exam.user
    @exam = exam
    mail to: @user.email, subject: t("exam_mailer.title")
  end

end
