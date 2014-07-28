class ContactsController < ApplicationController

  def show
    
  end

  def new
    @contact = Setting.email
    @user = current_user
  end

  def create
    if current_user
      @email = current_user.email
    else
      @email = params["Contact"]["email"]
    end
    @message = params["Contact"]["message"]
    ContactMailer.contact_email(@email).deliver
    flash[:success] = "Thank you for contacting us!"
    redirect_to root_path
  end
end
