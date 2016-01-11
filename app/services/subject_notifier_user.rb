class SubjectNotifierUser

  def mail_to_user_when_create subject
    NewSubject.perform_async subject.id
  end

end
