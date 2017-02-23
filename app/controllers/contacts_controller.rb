class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
        
        if @contact.save
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            
            #refer to contact_mailer.rb in mailers folder
            @contact = Contact.new(contact_params)
            
            flash[:success] = "Message sent."
            redirect_to new_contact_path
            ContactMailer.contact_email(name, email, body).deliver
        else
            flash[:danger] = "Error occured. Message has not been sent."
            redirect_to new_contact_path
        end
    end
    
    private
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end