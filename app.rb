require('sinatra')
require('sinatra/contrib/all')

require_relative('./controllers/company_controller.rb')
require_relative('./controllers/lead_controller.rb')

get '/' do
  erb( :index )
end