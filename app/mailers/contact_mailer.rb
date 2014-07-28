class ContactMailer < ActionMailer::Base

  def contact_email(email, message)
    @email = email
    @message = message
    mail(to: Setting.email, from: @email, subject: "Contact from OSU Art Walk")
  end
end
