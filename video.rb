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
  
  # STDERR.puts "Uploading file, original name #{name.inspect}"
  File.open("./files/"+Time.now.to_i.to_s+"-"+name, 'w') do |f|
    f.write(tempfile.read)
  end

  
  puts "Upload complete"
  200
end

