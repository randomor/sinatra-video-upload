require 'sinatra'
require 'aws'

get '/upload' do
    haml :upload, :format => :html5
end

post '/upload' do
  unless params[:file] &&
         (tempfile = params[:file][:tempfile]) &&
         (name = params[:file][:filename])
    @error = "No file selected"
    return haml(:upload)
  end

  
  s3 = AWS::S3.new(
  :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  )

  bucket = s3.buckets[ENV['S3_BUCKET_NAME']]

  obj = bucket.objects["#{name}"]
  obj.write(tempfile.read)

  puts "Uploaded!"
end

