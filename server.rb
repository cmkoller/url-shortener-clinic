require 'sinatra'
require 'pg'
require 'pry'
require 'sinatra/flash'

enable :sessions

def db_connection
  begin
    connection = PG.connect(dbname: "urls")
    yield(connection)
  ensure
    connection.close
  end
end

def get_urls
  db_connection do |conn|
    conn.exec("SELECT * FROM urls;")
  end
end

def generate_short_url
  result = ""
  4.times do
    result += ("a".."z").to_a.sample
    result += ("0".."9").to_a.sample
  end
  result
end

def is_in_db?(long)
  matches = db_connection do |conn|
    conn.exec_params("SELECT * FROM urls WHERE long = $1", [long])
  end

  matches.any?
end

get "/" do
  erb :index, locals: { urls: get_urls }
end

post "/" do
  long = params[:long_url]
  short = generate_short_url

  if is_in_db?(long)
    flash[:error] = "That URL has already been submitted!"
    erb :index, locals: { urls: get_urls }
  else
    db_connection do |conn|
      conn.exec_params("INSERT INTO urls (long, short) VALUES ($1, $2)", [long, short])
    end
    redirect "/"
  end
end

get "/:short_url" do
  short = params[:short_url]

  long_result = db_connection do |conn|
    conn.exec_params("SELECT long FROM urls WHERE short = $1", [short])
  end

  long_url = long_result.first["long"]

  redirect "http://" + long_url
end
