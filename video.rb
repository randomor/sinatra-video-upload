require 'sinatra'
require 'aws/s3'
require 'mime/types'

get '/upload' do
    haml :upload, :format => :html5
end

post '/upload' do
  unless params[:file] &&
         (tmpfile = params[:file][:tempfile]) &&
         (name = params[:file][:filename])
    @error = "No file selected"
    return haml(:upload)
  end
  
  local_file = tmpfile
  bucket = ENV['S3_BUCKET_NAME']
  mime_type = MIME::Types.type_for(name) || "application/octet-stream"

  AWS::S3::Base.establish_connection!(
  :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  )

  base_name = name

  puts "Uploading #{local_file} as '#{base_name}' to '#{bucket}'"

  AWS::S3::S3Object.store(
    base_name,
    local_file.read,
    bucket,
    :content_type => mime_type
  )

  puts "Uploaded!"
end

