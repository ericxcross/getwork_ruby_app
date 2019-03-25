require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('../models/lead')

get '/lead' do
  @leads = Lead.all()
  erb (:index)
end
