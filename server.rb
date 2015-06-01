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
