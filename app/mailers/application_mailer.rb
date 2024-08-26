# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def find_user(user)
    user.class.name.constantize.find_by_id(user.id)
  end
end
