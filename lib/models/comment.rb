class Comment
  include DataMapper::Resource
  property :id,         String,  :key => true,      :unique_index => true, :default => lambda { UUIDTools::UUID.random_create.to_i.to_base_62 }
  property :issue,      String,  :required => true
  property :line,       Integer, :required => true
  property :author,     String,  :required => true
  property :email,      String,  :required => true, :format => :email_address
  property :comment,    String,  :required => true
  property :created_at, DateTime  
end
