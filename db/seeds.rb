require_relative('../models/status.rb')
require_relative('../models/company.rb')
require_relative('../models/lead.rb')
require_relative('../models/action.rb')

## SEED STATUSES

Action.delete_all
Status.delete_all
Lead.delete_all
Company.delete_all

status1 = Status.new({
  'name' => 'Wishlist',
  'color' => 'purple'
})
status1.save

status2 = Status.new({
  'name' => 'Applied',
  'color' => 'red'
})
status2.save

status3 = Status.new({
  'name' => 'First Contact',
  'color' => 'orange'
})
status3.save

status4 = Status.new({
  'name' => 'Interview',
  'color' => 'yellow'
})
status4.save

status5 = Status.new({
  'name' => 'Offer Received',
  'color' => 'green'
})
status5.save

status6 = Status.new({
  'name' => 'Offer Accepted',
  'color' => 'blue'
})
status6.save

status7 = Status.new({
  'name' => 'Offer Rejected',
  'color' => 'grey'
})
status7.save

status8 = Status.new({
  'name' => 'No Offer',
  'color' => 'grey'
})
status8.save

##SEED COMPANIES

company1 = Company.new({
  'name' => 'BBC',
  'industry' => 'Broadcasting',
  'contact' => '40 Pacific Quay, Glasgow',
  'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'
})
company1.save

company2 = Company.new({
  'name' => 'NHS Lothian',
  'industry' => 'Healthcare',
  'contact' => '2-4 Waterloo Pl, Edinburgh',
  'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'
})
company2.save

company3 = Company.new({
  'name' => 'Skyscanner',
  'industry' => 'Tech',
  'contact' => '15 Lauriston Pl, Edinburgh',
  'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'
})
company3.save

company4 = Company.new({
  'name' => 'Codeclan',
  'industry' => 'Education',
  'contact' => '37 Castle Terrace, Edinburgh',
  'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'
})
company4.save

company5 = Company.new({
  'name' => 'RBS',
  'industry' => 'Banking',
  'contact' => '36 St Andrew Square, Edinburgh',
  'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.'
})
company5.save

###SEED ACTIONS
action1 = Action.new({
  'status_id' => status2.id,
  'due_date' => Date.today - 10,
  'summary' => 'Sumbit resume and cover letter'
  })
action1.save

action2 = Action.new({
  'status_id' => status3.id,
  'due_date' => Date.today + 3,
  'summary' => 'Follow up email to application'
  })
action2.save

action3 = Action.new({
  'status_id' => status4.id,
  'due_date' => Date.today + 15,
  'summary' => 'First meeting / interview at 12:30pm at Starbucks'
  })
action3.save

##SEED LEADS
lead1 = Lead.new({
  'company_id' => company1.id,
  'action_id' => action1.id,
  'name' => 'UX Designer 1',
  'link' => 'www.bbc.co.uk',
  'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
  'comments' => 'include new media project in application portfolio'
  })
lead1.save

lead2 = Lead.new({
  'company_id' => company3.id,
  'action_id' => action2.id,
  'name' => 'Senior Product Designer',
  'link' => 'www.skyscanner.com',
  'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
  'comments' => 'include new media project in application portfolio'
  })
lead2.save

lead3 = Lead.new({
  'company_id' => company5.id,
  'action_id' => action3.id,
  'name' => 'Service Designer',
  'link' => 'www.rbs.com',
  'summary' => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod rutrum felis, ac facilisis nulla posuere commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed rhoncus mauris vel orci volutpat elementum. Sed ultricies diam convallis lorem tristique luctus. Curabitur venenatis, augue at ultricies dignissim, odio lorem accumsan sem, at luctus neque orci vitae odio. Proin orci risus, sollicitudin eu semper vitae, dictum sit amet diam. Quisque convallis vitae diam eu bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
  'comments' => 'include new media project in application portfolio'
  })
lead3.save
