class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials[:smtp][:address]
  layout 'mailer'
end
