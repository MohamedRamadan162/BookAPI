# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/default_mailer
class DefaultMailerPreview < ActionMailer::Preview
  def default_email
    user = User.first!
    link = 'www.example.com'
    DefaultMailer.default_email('model.context', user, link,
                                { interpolation_test_en: 'This is a text to test interpolation through @opts variable',
                                  interpolation_test_ar: 'This is a text to test interpolation through @opts variable' })
  end
end
