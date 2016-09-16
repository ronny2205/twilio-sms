class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
      boot_twilio
      sms = @client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: '+1' + @message.phone_number,
        body: "This is a beautiful day!"
      )

      redirect_to root_path
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
