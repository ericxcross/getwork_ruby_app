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

# get '/lead/new' do
#   @companies = Company.all()
#   @status_list = Status.all()
#   erb(:"/lead/edit")
# end

# get '/lead/:id/edit' do #Edit / New Lead
#   @lead = Lead.find(params[:id])
#   @companies = Company.all()
#   @status_list = Status.all()
#   erb(:"/lead/edit")
# end

get '/lead/:id' do
  @lead = Lead.find(params[:id])
  @company = @lead.company
  @status_list = Status.all
  erb (:"/lead/show")
end

post '/lead/:id/new-action' do
  action = Action.new(params)
  action.save
  lead = Lead.find(params[:id])
  old_action_id = lead.action_id
  lead.action_id = action.id
  old_action = Action.find(old_action_id)
  old_action.delete
  lead.update

  redirect "/lead/#{params[:id]}"
end

# post '/lead/:id' do #EDIT or NEW
#
#   #check if company exists, return existing company or new company.
#   params['company_id'] = Company.company_by_name(params['company_name'])
#   #check if the the lead is being created or updated
#   # binding.pry
#   lead = Lead.new(params)
#   lead.id == 0 ? lead.save : lead.update
#
#   redirect '/lead'
# end
