class UserDecorator < Draper::Decorator
  delegate_all

  def status
    return "Admin" if admin?
    "User"
  end

end
