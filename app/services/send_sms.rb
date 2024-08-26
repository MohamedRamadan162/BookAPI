# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'

# TODO: to be tested
class SendSms
  def initialize(message, phone_number)
    @message = message
    @phone_number = phone_number
  end

  def call
    send_sms
  end

  private

  def send_sms
    request = set_request
    response = @http.request(request)
    JSON.parse(response.body)
  end

  def set_request
    request = add_headers(init_request)
    add_body(request)
  end

  def init_request
    url = URI(APP_CONFIG['CEQUENS_URL'])
    @http = Net::HTTP.new(url.host, url.port)
    @http.use_ssl = true

    Net::HTTP::Post.new(url)
  end

  def add_headers(request)
    request['Accept'] = 'application/json'
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{ENV.fetch('CEQUENS_TOKEN', nil)}"
    request
  end

  def add_body(request)
    request.body = {
      senderName: 'ProjectName',
      messageType: 'text',
      recipients: @phone_number,
      messageText: @message
    }.to_json
    request
  end

  attr_reader :message, :phone_number
end
