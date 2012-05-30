require 'controllers/issue_controller'
require 'controllers/comment_controller'

DataMapper.finalize

class Annoint::Application < Sinatra::Base
  set :static, true
  set :views, Annoint::ROOT + '/views'
  @title = "NTK"
  
  helpers do
    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end
  end
end

