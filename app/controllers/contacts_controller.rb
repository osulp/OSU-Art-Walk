class ContactsController < ApplicationController
  respond_to :html

  def show
    
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
      render :show
    else
      flash[:success] = "Thank you for contacting us!" if ContactMailer.contact_email(@email).deliver
      redirect_to contact_path
    end
  end
end
