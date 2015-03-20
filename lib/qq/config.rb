module QQ
  module Config

    def self.appid=(val)
      @@appid = val
    end

    def self.appid
      @@appid
    end

    def self.appkey=(val)
      @@appkey = val
    end

    def self.appkey
      @@appkey
    end

    def self.redirect_uri=(val)
      @@redirect_uri = val
    end

    def self.redirect_uri
      @@redirect_uri
    end

  end
end