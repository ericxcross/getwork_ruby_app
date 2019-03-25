require_relative('../models/status.rb')
require_relative('../models/company.rb')
require_relative('../models/lead.rb')

## SEED STATUSES
Status.delete_all

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
Company.delete_all

company1 = Company.new({
  'name' => 'BBC',
  'industry' => 'Broadcasting',
  'contact' => '40 Pacific Quay, Glasgow'
})
company1.save

company2 = Company.new({
  'name' => 'NHS Lothian',
  'industry' => 'Healthcare',
  'contact' => '2-4 Waterloo Pl, Edinburgh'
})
company2.save

company3 = Company.new({
  'name' => 'Skyscanner',
  'industry' => 'Tech',
  'contact' => '15 Lauriston Pl, Edinburgh'
})
company3.save

company4 = Company.new({
  'name' => 'Codeclan',
  'industry' => 'Education',
  'contact' => '37 Castle Terrace, Edinburgh'
})
company4.save

company5 = Company.new({
  'name' => 'RBS',
  'industry' => 'Banking',
  'contact' => '36 St Andrew Square, Edinburgh'
})
company5.save

##SEED LEADS
Lead.delete_all

lead1 = Lead.new({
  'company_id' => company1.id,
  'status_id' => status1.id,
  'name' => 'UX Designer 1',
  'link' => 'www.bbc.co.uk',
  'summary' => 'another job',
  'comments' => 'include new media project in application portfolio'
  })
lead1.save
