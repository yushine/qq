module QQ
  class User
    attr_accessor :openid, :name, :avatar

    def initialize(*args)
      if args[0][:code].present?
        state = Digest::MD5.hexdigest(rand.to_s)
        url = 'https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&' +
            "client_id=#{QQ::Config.appid}&" +
            "client_secret=#{QQ::Config.appkey}&" +
            "code=#{code}&state=#{state}&" +
            "redirect_uri=#{QQ::Config.redirect_uri}"
        @token = open(url).read[/(?<=access_token=)\w{32}/]
        @openid = get_openid(@token)
      elsif args[0][:token].present?
        @token = args[0][:token]
        args[0][:openid].present? ? @openid = args[0][:openid] : @openid = get_openid(@token)
      end
      @auth = "?access_token=#{@token}&oauth_consumer_key=#{QQ::Config.appid}&openid=#{@openid}"
      get_user_info
    end

    def get_openid(token)
      url = "https://graph.qq.com/oauth2.0/me?access_token=#{token}"
      open(url).read[/\w{32}/]
    end

    def get_user_info
      @data = open('https://graph.qq.com/user/get_user_info' + @auth).read.force_encoding('utf-8')
      @data = MultiJson.decode(@data)
      return fail @data['ret'].to_s + ': ' + @data['msg'] if @data['ret'] != 0
      @name = @data['nickname']
      @avatar = @data['figureurl_qq_2'] || @data['figureurl_qq_1']
    end

    def method_missing(*params)
      case params[0]
        when /^get_.*|^list_.*|^check_.*/
          back = open(params[1] + @auth + params[2].to_s).read.force_encoding('utf-8')
        when /.*pic.*/
          return fail 'no block given' unless block_given?
          url = URI(yield['url'])
          request = {'access_token' => @token,
                     'oauth_consumer_key' => appid,
                     'openid' => @openid}.merge(yield)
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