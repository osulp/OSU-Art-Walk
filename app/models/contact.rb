class Contact < MailForm::Base
  def headers
    {
    :subject => "Contact from OSU Art Walk",
    :to => Setting.email,
    :from => User.email
    }
  end
end
