require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('../models/lead')
require_relative('../models/company')
require_relative('../models/status')

get '/lead' do
  @leads = Lead.all()
  erb (:"/lead/index")
end

get '/lead/:id' do
  @lead = Lead.find(params[:id])
  @company = @lead.company
  erb (:"/lead/show")
end
