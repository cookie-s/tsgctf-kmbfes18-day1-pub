require 'json'

require 'sqlite3'
require 'sinatra/base'

def sql_escape(x)
  x.gsub("'", "''")
end

class Simqle < Sinatra::Base
  DB = SQLite3::Database.new 'tsg.db'

  configure do
    use Rack::Logger
    mime_type :source, 'text/plain'
  end

  get '/' do
    erb :index
  end

  get '/source' do
    content_type :source
    IO.binread(__FILE__)
  end

  post '/search' do
    sleep 0.5

    params = JSON.parse request.body.read rescue return 400
    %w(name since until title url).each do |key|
      return 400 if params[key] && params[key].bytesize > 500
    end
    return 400 if params["name"] && params["name"].bytesize > 20

    filter = "name LIKE '%%%s%%'" % params["name"]
    filter+= params["since"] && params["until"] ?
      " AND year BETWEEN %d AND %d" % [params["since"].to_i, params["until"].to_i] : ''
    filter+= params["title"] ?
      " AND title LIKE '%%%s%%'" % sql_escape(params["title"]) : ''
    filter+= params["url"] ?
      " AND url LIKE '%%%s%%'" % sql_escape(params["url"]) : ''

    sql = "SELECT name, year, title, url FROM members WHERE %s ORDER BY id DESC" % filter
    res = DB.execute(sql).map{|name, year, title, url| {name: name, year: year, title: title, url: url}} rescue nil

    res ? logger.info(sql) : logger.warn(sql)

    {data: res}.to_json
  end
end
