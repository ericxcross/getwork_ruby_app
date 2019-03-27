require_relative('../models/status.rb')
require_relative('../models/lead.rb')
require_relative('../models/action.rb')

## SEED STATUSES

Lead.delete_all
Action.delete_all
Status.delete_all

status1 = Status.new({
  'name' => 'No Current Tasks',
  'color' => 'grey',
  'archive' => false
})
status1.save

status2 = Status.new({
  'name' => 'Interested',
  'color' => 'grey',
  'archive' => false
})
status2.save

status3 = Status.new({
  'name' => 'Submit Application',
  'color' => 'red',
  'archive' => false
})
status3.save

status4 = Status.new({
  'name' => 'Reply Pending',
  'color' => 'red',
  'archive' => false
})
status4.save

status5 = Status.new({
  'name' => 'Follow Up',
  'color' => 'orange',
  'archive' => false
})
status5.save

status6 = Status.new({
  'name' => 'Interview',
  'color' => 'yellow',
  'archive' => false
})
status6.save

status7 = Status.new({
  'name' => 'Offer Received',
  'color' => 'green',
  'archive' => false
})
status7.save

status8 = Status.new({
  'name' => 'Offer Accepted',
  'color' => 'blue',
  'archive' => true
})
status8.save

status9 = Status.new({
  'name' => 'Offer Turned Down',
  'color' => 'grey',
  'archive' => true
})
status9.save

status10 = Status.new({
  'name' => 'Application Rejected',
  'color' => 'grey',
  'archive' => true
})
status10.save

status11 = Status.new({
  'name' => 'Note',
  'color' => 'grey',
  'archive' => false
})
status11.save

status12 = Status.new({
  'name' => 'No Current Tasks',
  'color' => 'grey',
  'archive' => false
})
status12.save

##SEED LEADS
lead1 = Lead.new({
  'company_name' => 'BBC',
  'name' => 'UX Designer 1',
  'link' => 'www.bbc.co.uk',
  'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
  'comments' => 'include new media project in application portfolio'
  })
lead1.save
#
# lead2 = Lead.new({
#   'company_name' => 'Skyscanner',
#   'name' => 'Senior Product Designer',
#   'link' => 'www.skyscanner.com',
#   'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
#   'comments' => 'include new media project in application portfolio'
#   })
# lead2.save
#
# lead3 = Lead.new({
#   'company_name' => 'RBS',
#   'name' => 'Service Designer',
#   'link' => 'www.rbs.com',
#   'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
#   'comments' => 'include new media project in application portfolio'
#   })
# lead3.save
#
# lead4 = Lead.new({
#   'company_name' => 'RBS',
#   'name' => 'UX Designer',
#   'link' => 'www.rbs.com',
#   'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
#   'comments' => 'include new media project in application portfolio'
#   })
# lead4.save

###SEED ACTIONS
action1 = Action.new({
  'status_id' => status2.id,
  'lead_id' => lead1.id,
  'date_completed' => DateTime.new(2019,3,3,0,0,0),
  'summary' => 'Sumbit resume and cover letter',
  'completed' => true
  })
action1.save

action2 = Action.new({
  'status_id' => status4.id,
  'lead_id' => lead1.id,
  'date_completed' => DateTime.new(2019,3,26,0,0,0),
  'summary' => 'Send Charles from HR an email',
  'completed' => true
  })
action2.save

action1 = Action.new({
  'status_id' => status5.id,
  'lead_id' => lead1.id,
  'date_completed' => DateTime.new(2019,5,2,0,0,0),
  'summary' => 'Negotiate Salary',
  'completed' => false
  })
action1.save
