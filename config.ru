# Almostly taken from http://qiita.com/masuidrive/items/1042d93740a7a72242a3

require 'bundler/setup'
require 'sinatra/base'
require 'json'
require 'rest-client'


class App < Sinatra::Base
  get '/' do
    "Hello World!"
  end

  post '/callback' do
    params = JSON.parse(request.body.read)

    params['result'].each do |msg|
      request_content = {
        to: [msg['content']['from']],
        toChannel: 1383378250, # Fixed  value
        eventType: "138311608800106203", # Fixed value
        content: msg['content']
      }

      endpoint_uri = 'https://trialbot-api.line.me/v1/events'
      content_json = request_content.to_json

      RestClient.proxy = 'http://fixie:S5RArp1neEfosfX@velodrome.usefixie.com:80'
      RestClient.post(endpoint_uri, content_json, {
        'Content-Type' => 'application/json; charset=UTF-8',
        'X-Line-ChannelID' => '1462016721',
        'X-Line-ChannelSecret' => 'f2816c5f890988372795d7245000651a',
        'X-Line-Trusted-User-With-ACL' => 'u9f218ae0bbd7bdf568f3714324d2ee9a',
      })
    end

    "OK"
  end
end

run App
