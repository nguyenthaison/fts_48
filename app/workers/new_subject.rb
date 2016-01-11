class NewSubject
  include Sidekiq::Worker

  def perform subject_id
    @subject = Subject.find subject_id
    User.normal.each do |user|
      UserNotifier.send_when_create_subject(user, @subject)
    end
  end
end
