require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('../models/lead.rb')
require_relative('../models/action.rb')
require_relative('../models/status.rb')
require_relative('../models/action_log.rb')

also_reload('../models/*')

#SORTING GETTERS
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

#SHOW
get '/lead/:id' do
  @lead = Lead.find(params[:id])
  @status_list = Status.all
  @action_log = @lead.action_log
  erb (:"/lead/show")
end

#ADD NEW ACTION AND ARCHIVE OLD ACTION
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
  ActionLog.archive(old_action)
  lead.update
  #delete old action (automatically added to action log)

  old_action.delete

  redirect "/lead/#{params[:id]}"
end

#DELETE LOGGED ACTION
post '/lead/action-log/:action_id' do
  action = ActionLog.find(params[:action_id])
  action.delete
  redirect "/lead/#{params['id']}"
end

#DELETE CURRENT ACTION AND REPLACE WITH DEFAULT
post '/lead/action/:action_id' do
  lead = Lead.find(params['id'])
  lead.action_id = Action.default
  lead.update
  action = Action.find(params[:action_id])
  action.delete
  redirect "/lead/#{params['id']}"
end

post '/lead/:id/cancel' do #EDIT
  redirect "/lead/#{params['id']}"
end

post '/lead/:id/delete' do #EDIT
  lead = Lead.find(params[:id])
  lead.delete
  redirect "/lead"
end

post '/lead/:id' do #EDIT
  lead = Lead.new(params)
  lead.update
  redirect "/lead/#{lead.id}"
end

post '/lead' do #NEW
  lead = Lead.new(params)
  lead.save
  redirect "/lead/#{lead.id}"
end
