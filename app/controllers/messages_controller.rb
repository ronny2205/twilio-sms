class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
      boot_twilio
      sms = @client.messages.create(
        # from: ENV['TWILIO_NUMBER'],
        from: '+16313235078',
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
    # account_sid = ENV['TWILIO_ACCOUNT_SID']
    # auth_token = ENV['TWILIO_AUTH_TOKEN']
    account_sid = 'AC144db403f1bcc71113164f7deaf53a2c'
    auth_token = '4dca77ff4b37cba99cfb3d7a67292f48'
    @client = Twilio::REST::Client.new account_sid, auth_token
  end
end
