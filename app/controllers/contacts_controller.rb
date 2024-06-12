class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      session[:contact_params] = @contact.attributes
      redirect_to root_path, notice: "問い合わせを受け付けました。"
    else
      render :new
    end
  end  

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :message)
  end
end
