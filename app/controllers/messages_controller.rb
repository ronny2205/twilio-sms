class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    dest_number = @message.phone_number.gsub(/[^\d]/, '')
    if @message.valid?
      begin
        boot_twilio
        sms = @client.messages.create(
          from: ENV['TWILIO_PHONE_NUMBER'],
          to: '+1' + dest_number,
          body: "This is a beautiful day!"
        )
      rescue Twilio::REST::RequestError => e
        flash[:error] = "Seems like that wasn't a valid phone number. Want to try again?"
      else
        flash[:notice] = "The message is on its way to you..."
      end 
      redirect_to root_path
    else
      render :new, :status => :unprocessable_entity
    end  
  end

  private

  def message_params
    params.require(:message).permit(:phone_number)
  end

  def boot_twilio
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
  end
end
