class ContactsController < ApplicationController
  respond_to :html

  def show
    
  end

  def create
    @email = current_user.email if current_user
    @email ||= contact_params["email"]
    @message = contact_params["message"]
    if @email.blank?
      flash[:error] = "Please enter an email address and try again"
      render :show
    else
      flash[:success] = "Thank you for contacting us!" if ContactMailer.contact_email(@email).deliver
      redirect_to contact_path
    end
  end

  private
  def contact_params
    params["Contact"]
  end

end
