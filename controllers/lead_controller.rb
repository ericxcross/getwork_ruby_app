require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('../models/lead.rb')
require_relative('../models/action.rb')
require_relative('../models/status.rb')

also_reload('../models/*')

#SORTING GETTERS
get '/lead' do
  @leads = Lead.all_by_update
  @sort = 'update'
  erb (:"/lead/index")
end

get '/lead/sort-by-status' do
  @leads = Lead.all_by_status()
  @sort = 'status'
  erb (:"/lead/index")
end

get '/lead/sort-by-name' do
  @leads = Lead.all_by_name()
  @sort = 'name'
  erb (:"/lead/index")
end

get '/lead/sort-by-action-date' do
  @leads = Lead.all_by_action_date
  @sort = 'action_date'
  erb (:"/lead/index")
end

#CREATE, EDIT
get '/lead/new' do
  @status_list = Status.all()
  erb(:"/lead/new")
end

get '/lead/:id/edit' do #Edit / New Lead
  @lead = Lead.find(params[:id])
  @status_list = Status.all()
  erb(:"/lead/edit")
end

#SHOW LEAD
get '/lead/:id' do
  @lead = Lead.find(params[:id])
  @status_list = Status.all
  @actions_list = @lead.actions
  @primary_action = @lead.primary_action
  erb (:"/lead/show")
end

#CANCEL FORM
post '/lead/:id/cancel' do
  redirect "/lead/#{params['id']}"
end

#DELETE LEAD
post '/lead/:id/delete' do
  lead = Lead.find(params[:id])
  lead.delete
  redirect "/lead"
end

#UPDATE LEAD
post '/lead/:id' do
  lead = Lead.new(params)
  lead.update
  redirect "/lead/#{lead.id}"
end

#SAVE NEW LEAD
post '/lead' do
  lead = Lead.new(params)
  lead.save
  redirect "/lead/#{lead.id}"
end
