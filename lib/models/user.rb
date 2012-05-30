class User
  BUCKETS = [:io, :si, :sdtc]
  
  include DataMapper::Resource
  property :id,         String, :key => true, :unique_index => true, :default => lambda { UUIDTools::UUID.random_create.to_i.to_base_62 }
  property :name,       String, :required => true
  property :email,      String, :required => true, :unique => true, :format => :email_address
  property :bucket,     String, :required => true, :default => lambda { BUCKETS.choose } 
  property :created_at, DateTime  
  
  def questionnaire_url
    Kris::CONFIG['questionnaires'][bucket.to_s]
  end

  # TODO have a list of modules and choices
  def current_module 
    "foo"
  end
end
