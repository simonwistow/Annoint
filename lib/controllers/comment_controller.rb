class Annoint::Application < Sinatra::Base

  
  get '/issue/:year/:month/:day/comments' do |year, month, day|
    content_type :json    
    comments = Comment.all(:issue => "#{year}/#{month}/#{day}", :order => [ :line.desc ] )
    ordered  = []
    comments.each do |comment| 
      ordered[comment.line] ||= []
      ordered[comment.line].push(:email => comment.email, :author => comment.author, :comment => comment.comment, :created_at => comment.created_at)
    end
    
    ordered.map{ |val| val || [] }.to_json
  end
  
  post '/issue/:year/:month/:day/comments/:line' do |year, month, day, line|
    content_type :json   
    comment = Comment.first_or_create(:email => params["email"], :author => params["author"], :line => line, :issue => "#{year}/#{month}/#{day}", :comment => params["comment"])
    comment.to_json
  end
end