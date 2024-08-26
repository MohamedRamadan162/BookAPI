# frozen_string_literal: true

class DefaultMailer < ApplicationMailer
  def default_email(template, user, link = nil, opts = {})
    @template = template
    @user = find_user(user)
    @link = link
    @opts = opts
    I18n.with_locale(@user.locale) do
      mail(to: "<#{user.email}>", subject: I18n.t("mailer.#{@template}.subject", locale: user.locale, **@opts))
    end
  end
end
