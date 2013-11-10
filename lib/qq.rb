require 'open-uri'
require 'net/http'
class Qq
	attr_reader :token,:openid,:auth
	#获取令牌:认证码code=params[:code],httpstat=request.env['HTTP_CONNECTION']
	def initialize(code,httpstat)
		#获取令牌
		@token ||= open('https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id=' + APPID + '&client_secret=' + APPKEY + '&code=' + code + '&state='+ httpstat + REDURL).read[/(?<=access_token=)\w{32}/]
		#获取Openid
		@openid ||= open('https://graph.qq.com/oauth2.0/me?access_token=' + @token).read[/\w{32}/]		
		#获取通用验证参数
		@auth ||= '?access_token=' + @token + '&oauth_consumer_key=' + APPID + '&openid=' + @openid
	end
	#调用API,格式为:腾讯API接口(网址,参数).
	def method_missing(*params)
		case params[0]
		when /^get_.*|^list_.*|^check_.*/
			back=open(params[1] + @auth + params[2].to_s).read.force_encoding('utf-8')
		when /.*pic.*/
			raise 'no block given' unless block_given?
			url=URI(yield['url'])
			request={'access_token' => @token,'oauth_consumer_key' => APPID,'openid' => @openid}.merge(yield)
			back=Net::HTTP.post_form(url,request).body
		when /^add_.*|^del_.*/
			url=URI(params[1])
			back=Net::HTTP.new(url.host,443)
			back.use_ssl=true
			back=back.post(url.path,@auth[1..-1] + params[2]).body
		else
			raise 'API not found'		
		end
		back=MultiJson.decode(back)
		raise back['ret'].to_s + ': ' + back['msg'] if back['ret'] != 0
		return back
	end	
end