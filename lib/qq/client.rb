module QQ
  class Client < OAuth2::Client
    attr_accessor :access_token

    def initialize(client_id='', client_secret='', opts={}, &block)
      client_id = QQ::Config.appid
      client_secret = QQ::Config.appkey
      super
      @site = "https://graph.qq.com/"
      @options[:state] = Digest::MD5.hexdigest(rand.to_s)
      @options[:authorize_url] = '/oauth2.0/authorize'
      @options[:token_url] = '/oauth2/access_token'
    end

    def authorize_url(params={})
      params[:client_id] = @id unless params[:client_id]
      params[:response_type] = 'code' unless params[:response_type]
      params[:redirect_uri] = "mirugo.com/qq/callback" unless params[:redirect_uri]
      super
    end
  end
end
