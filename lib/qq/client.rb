require 'open-uri'
require 'net/http'
# QQ Connect
module Qq
  class Client
    attr_reader :openid
    # code = params[:code]
    # get appid & appkey from http://opensns.qq.com
    def initialize(code)
      # CSRF
      state = Digest::MD5.hexdigest(rand.to_s)
      # get token
      url = 'https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&' + 
  "client_id=#{Qq::Config.appid}&" + 
  "client_secret=#{Qq::Config.appkey}&" + 
  "code=#{code}&state=#{state}&" + 
  "redirect_uri=#{Qq::Config.redirect_uri}"
      @token = open(url).read[/(?<=access_token=)\w{32}/]
      # return fail 'CSRF detected' if params[:state] != state
      # get openid
      url = "https://graph.qq.com/oauth2.0/me?access_token=#{@token}"
      @openid = open(url).read[/\w{32}/]
      # get auth
      @auth = "?access_token=#{@token}&oauth_consumer_key=#{Qq::Config.appid}&\
  openid=#{@openid}"
    end

    def method_missing(*params)
      case params[0]
      when /^get_.*|^list_.*|^check_.*/
        back = open(params[1] + @auth + params[2].to_s).read.force_encoding('utf-8')
      when /.*pic.*/
        return fail 'no block given' unless block_given?
        url = URI(yield['url'])
        request = { 'access_token' => @token,
                    'oauth_consumer_key' => appid,
                    'openid' => @openid }.merge(yield)
        back = Net::HTTP.post_form(url, request).body
      when /^add_.*|^del_.*/
        url = URI(params[1])
        back = Net::HTTP.new(url.host, 443)
        back.use_ssl = true
        back = back.post(url.path, @auth[1..-1] + params[2]).body
      else
        return fail 'API not found'
      end
      back = MultiJson.decode(back)
      return fail back['ret'].to_s + ': ' + back['msg'] if back['ret'] != 0
      back
    end
  end
end
