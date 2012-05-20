require 'sinatra'
require 'aws'

get '/upload' do
    haml :upload, :format => :html5
end

post '/upload' do
  puts "uploading..."
  puts params
  
  unless params[:file] &&
         (tempfile = params[:file][:tempfile]) &&
         (name = params[:file][:filename])
    @error = "No file selected"
    return haml(:upload)
  end
<<<<<<< HEAD
<<<<<<< HEAD

=======
=======
  
  # STDERR.puts "Uploading file, original name #{name.inspect}"
  
>>>>>>> added status code return and log output
  
  # STDERR.puts "Uploading file, original name #{name.inspect}"
  
>>>>>>> added status code return and log output
  
  s3 = AWS::S3.new(
  :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  )

<<<<<<< HEAD
  bucket = s3.buckets[ENV['S3_BUCKET_NAME']]

<<<<<<< HEAD
  obj = bucket.objects["#{name}"]
  obj.write(tempfile.read)

  puts "Uploaded!"
=======
  puts "Upload complete"
  
  200
>>>>>>> added status code return and log output
=======
  puts "Upload complete"
  
  200
>>>>>>> added status code return and log output
end

