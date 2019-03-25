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

get '/lead/:id/edit' do #Edit / New Lead
  @lead = Lead.find(params[:id])
  @companies = Company.all()
  @status_list = Status.all()
  erb(:"/lead/edit")
end

get '/lead/:id' do
  @lead = Lead.find(params[:id])
  @company = @lead.company
  erb (:"/lead/show")
end

post '/lead/:id' do #Post back EDIT or NEW
  @lead = Lead.new(params)
  params[:id] == 0 ? @lead.save : @lead.update
  redirect '/lead'
end
