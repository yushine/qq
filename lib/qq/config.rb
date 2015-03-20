module Qq
  module Config

    def self.appid=(val)
      @@api_key = val
    end

    def self.appid
      @@api_key
    end

    def self.appkey=(val)
      @@api_secret = val
    end

    def self.appkey
      @@api_secret
    end

    def self.redirect_uri=(val)
      @@redirect_uri = val
    end

    def self.redirect_uri
      @@redirect_uri
    end

  end
end