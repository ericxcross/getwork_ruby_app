require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')

require_relative('../models/lead.rb')
require_relative('../models/action.rb')
require_relative('../models/status.rb')

also_reload('../models/*')

#TO EDIT
get '/action/:id/edit' do
  @action = Action.find(params[:id])
  @lead = Lead.find(@action.lead_id)
  @status_list = Status.all
  erb (:"/action/edit")
end

#MARK ACTION COMPLETE
get '/action/:id/complete' do
  newly_completed_action = Action.find(params[:id])
  newly_completed_action.completed = true
  newly_completed_action.date_completed = DateTime.now
  newly_completed_action.update
  redirect "/lead/#{newly_completed_action.lead_id}}"
end

#DELETE ACTION
post 'action/:id/delete' do
  deleted_action = Action.find(params[:id])
  deleted_action.delete
  redirect "/lead/#{deleted_action.lead_id}"
end

#NEW ACTION
post '/action/new' do
  action = Action.new(params)
  action.save
  redirect "/lead/#{action.lead_id}"
end

#EDIT ACTION
post '/action/:id' do
  action = Action.new(params)
  action.update
  redirect "/lead/#{action.lead_id}"
end
