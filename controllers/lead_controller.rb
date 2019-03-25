require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('../models/lead.rb')
require_relative('../models/company.rb')
require_relative('../models/status.rb')

also_reload('../models/*')

get '/lead' do
  @leads = Lead.all()
  erb (:"/lead/index")
end

get '/lead/new' do
  @companies = Company.all()
  @status_list = Status.all()
  erb(:"/lead/edit")
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

post '/lead/:id' do #EDIT or NEW

  #check if company exists, return existing company or new company.
  params['company_id'] = Company.company_by_name(params['company_name'])
  #check if the the lead is being created or updated
  # binding.pry
  lead = Lead.new(params)
  lead.id == 0 ? lead.save : lead.update

  redirect '/lead'
end
