require 'timeout'

require 'sinatra/base'

class SHA < Sinatra::Base
  configure do
    use Rack::Logger
    mime_type :source, 'text/plain'
  end

  get '/' do
    erb :index
  end

  get '/source' do
    content_type :source
    Kernel.` 'cat %s' % __FILE__
  end

  post '/sha' do
    salt = params[:salt]
    file = params[:file] || 'flag'
    logger.info [salt, file]

    code = <<-END
    require 'digest/sha2'
    s = #{salt.inspect} + IO.binread(%p.gsub(?/,''))
    puts Digest::SHA512.hexdigest(s)
    END
    code = code % file

    res = nil

    begin
      Timeout.timeout(1) do
        IO.popen("ruby", "r+") do |io|
          io.puts code
          io.close_write

          res = io.read
        end
      end
    rescue Timeout::Error
      return 'timeout'
    end

    res
  end
end
