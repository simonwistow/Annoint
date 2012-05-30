class Annoint::Application < Sinatra::Base
  @@issue_cache = {}
  
  get '/issue/:year/:month/:day' do |year, month, day|
    year   = 1900+year.to_i if year.to_i < 100
    @date  = DateTime.new(year.to_i, month.to_i, day.to_i)
    @title = "Need To Know #{@date.strftime('%Y-%m-%d')}"
    @issue = fetch_issue(@date)
    
    not_found unless @issue
    
    @lines  = @issue.split(/\n/)
    erb :issue
  end
  
  private
  
  def fetch_issue(date)
    key      = date.strftime('%Y-%m-%d').to_sym
    filename = "public/issues/#{date.strftime('%Y/now%m%d')}.txt"
    begin 
      @@issue_cache[date] ||= File.open(filename, "rb") { |f| f.read }
    rescue Errno::ENOENT => e
      nil
    end
  end
  
end