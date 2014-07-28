class ContactsController < ApplicationController
  respond_to :html

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
    if @email == nil || @email == ""
      flash[:error] = "Please enter an email address and try again"
    else
      flash[:success] = "Thank you for contacting us!" if ContactMailer.contact_email(@email).deliver
    end
    redirect_to contact_path
  end
end
