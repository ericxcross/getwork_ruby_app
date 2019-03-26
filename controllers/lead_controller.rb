require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('../models/lead.rb')
require_relative('../models/company.rb')
require_relative('../models/action.rb')
require_relative('../models/status.rb')

also_reload('../models/*')

# SORTING FUNCTIONS
get '/lead' do
  @leads = Lead.all_by_due_date()
  erb (:"/lead/index")
end

get '/lead/sort-by-status' do
  @leads = Lead.all_by_status()
  erb (:"/lead/index")
end

get '/lead/sort-by-name' do
  @leads = Lead.all_by_name()
  erb (:"/lead/index")
end

get '/lead/sort-by-last-updated' do
  @leads = Lead.all_by_update
  erb (:"/lead/index")
end

get '/lead/new' do
  @companies = Company.all()
  @status_list = Status.all()
  erb(:"/lead/new")
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
  @status_list = Status.all
  erb (:"/lead/show")
end

post '/lead/:id/new-action' do
  action = Action.new(params)
  action.save
  #find lead by ID
  lead = Lead.find(params[:id])
  #tag old action
  old_action = lead.action
  #overwrite old action ID with new action
  lead.action_id = action.id
  #update lead with new action
  lead.update
  #delete old action (automatically added to action log)
  old_action.delete
  redirect "/lead/#{params[:id]}"
end

post '/lead' do #NEW
  lead = Lead.new(params)
  params['status_id'] = Status.all.first.id

  lead.save

  redirect "/lead/#{lead.id}"
end
