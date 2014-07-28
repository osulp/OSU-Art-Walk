class ContactMailer < ActionMailer::Base

  def contact_email(email)
    mail(to: Setting.email, from: email, subject: "Contact from OSU Art Walk")
  end
end
