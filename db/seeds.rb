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
  'completed' => true
})
status1.save

status2 = Status.new({
  'name' => 'Interested',
  'color' => 'grey',
  'completed' => true
})
status2.save

status3 = Status.new({
  'name' => 'Submit Application',
  'color' => 'mint',
  'completed' => false
})
status3.save

status4 = Status.new({
  'name' => 'Reply Pending',
  'color' => 'grey',
  'completed' => false
})
status4.save

status5 = Status.new({
  'name' => 'Follow Up',
  'color' => 'mint',
  'completed' => false
})
status5.save

status6 = Status.new({
  'name' => 'Interview',
  'color' => 'mint',
  'completed' => false
})
status6.save

status7 = Status.new({
  'name' => 'Offer Received',
  'color' => 'mint',
  'completed' => false
})
status7.save

status8 = Status.new({
  'name' => 'Offer Accepted',
  'color' => 'mint',
  'completed' => true
})
status8.save

status9 = Status.new({
  'name' => 'Offer Turned Down',
  'color' => 'grey',
  'completed' => true
})
status9.save

status10 = Status.new({
  'name' => 'Application Rejected',
  'color' => 'grey',
  'completed' => true
})
status10.save

status11 = Status.new({
  'name' => 'Note',
  'color' => 'grey',
  'completed' => true
})
status11.save

##SEED LEADS
lead1 = Lead.new({
  'company_name' => 'BBQ',
  'name' => 'UX Designer Trainee Scheme',
  'link' => 'https://www.bbc.co.uk/careers/trainee-schemes-and-apprenticeships/technology/ux-design',
  'summary' => "To build the best UX team in the business, we’re doing all we can to nurture the next generation of design superstars. That means you! This is your chance to join our team of innovative and supportive UX designers. Get involved with the insight, imagination and regular research we use to create incredible experiences for people across the world. On this year-long programme you'll rotate across a range of products – from iPlayer to News, from Sport to CBeebies. You’ll work on real projects with senior members of UX, as well as technical and editorial teams from across the BBC. You’ll gain unparalleled experience, as you get involved in user research, information architecture, content analysis, interaction design, visual design, prototyping and much more. We’ve got placements available in London and/or Salford. So your location could be flexible depending on what suits you.",
  })
lead1.save

###SEED ACTIONS
action1 = Action.new({
  'status_id' => status3.id,
  'lead_id' => lead1.id,
  'date_completed' => DateTime.new(2019,3,3,0,0,0),
  'summary' => 'Sumbit resume and cover letter to online application',
  'completed' => true
  })
action1.save

action2 = Action.new({
  'status_id' => status5.id,
  'lead_id' => lead1.id,
  'date_completed' => DateTime.new(2019,3,26,0,0,0),
  'summary' => 'Follow up with updated client experience project',
  'completed' => true
  })
action2.save

action3 = Action.new({
  'status_id' => status6.id,
  'lead_id' => lead1.id,
  'date_completed' => DateTime.new(2019,7,2,0,0,0),
  'summary' => 'Skype interview with Jenn from the design team',
  'completed' => false
  })
action3.save

###LEAD 2
lead2 = Lead.new({
  'company_name' => 'Inc Blot',
  'name' => 'Product Designer',
  'link' => 'https://jobs.izettle.com/jobs/171872-digital-product-designer-edinburgh?utm_campaign=google_jobs_apply&utm_source=google_jobs_apply&utm_medium=organic',
  'summary' => "We're looking to add a Digital Designer to our growing Product team. We’re currently a small product team in Edinburgh. We’re creating a POS app that’s used by thousands of businesses every day.

  Started from the bottom now we’re here

  As a designer you will be given a lot of freedom and great responsibility to produce your best work. There are no design committees or lengthy middle management holdups, just a closely knit team to support you.

  We’re a small Product team in Edinburgh, part of the bigger family, that has over 500 employees across 5 offices worldwide. With regular trips to Stockholm and quarterly offsite meetings, you’ll quickly feel part of a wider team.",
  'last_updated' => DateTime.new(2019,2,3,0,0,0)
  })
lead2.save

###SEED ACTIONS
action4 = Action.new({
  'status_id' => status2.id,
  'lead_id' => lead2.id,
  'date_completed' => DateTime.new(2019,2,3,0,0,0),
  'summary' => '',
  'completed' => true
  })
action4.save

###LEAD 3
lead3 = Lead.new({
  'company_name' => 'Freedom Global',
  'name' => 'Digital Product Designer',
  'link' => 'https://uk.linkedin.com/jobs/view/digital-product-designer-at-freeagent-1191236727?utm_campaign=google_jobs_apply&utm_source=google_jobs_apply&utm_medium=organic',
  'summary' => "Are you:
• A strong visual/graphic designer?
• Experienced in designing user interfaces for complex applications?
• Customer and User focussed and hold their needs at the heart of your approach to solving design problems?
• Confident with HTML, CSS and JavaScript?
• Highly collaborative and comfortable working with other Product Designers and Engineers to deliver product features?

Well, hello there!

We are one of the leading online accounting platforms in the UK with over 70,000 customers and continued fast growth. We've got a world-class NPS score and this role is an opportunity to make a real difference to people and their businesses as we work towards making them happier and more successful by putting them in control of their finances.

We're looking for a highly skilled designer to join the product design team on our mission to make businesses happier and more successful by putting them in control of their finances.
",
  'last_updated' => DateTime.new(2019,3,26,0,0,0)
  })
lead3.save

action5 = Action.new({
  'status_id' => status3.id,
  'lead_id' => lead3.id,
  'date_completed' => DateTime.new(2019,3,5,0,0,0),
  'summary' => 'Send through application including side project in portfolio',
  'completed' => true
  })
action5.save

action6 = Action.new({
  'status_id' => status6.id,
  'lead_id' => lead3.id,
  'date_completed' => DateTime.new(2019,3,16,0,0,0),
  'summary' => 'Interview with Sara and Paul at company offices, bring portfolio for discussion',
  'completed' => true
  })
action6.save

action7 = Action.new({
  'status_id' => status7.id,
  'lead_id' => lead3.id,
  'date_completed' => DateTime.new(2019,4,02,0,0,0),
  'summary' => 'Get back by next week with answer',
  'completed' => false
  })
action7.save

###LEAD 4
lead4 = Lead.new({
  'company_name' => 'Zuchinni',
  'name' => 'UX Designer',
  'link' => 'https://jobs.apple.com/en-gb/details/200029135/ux-ui-designer',
  'summary' => "Zuchinni's core AI team is looking for a strong UX/UI designer to work on its Machine Learning platform. We have built the platform that Zuchinni uses for developing machine learning, artificial intelligence, and computer vision applications. As a UX/UI designer, you will have a chance to create new products and extend existing products that are part of it. You should be comfortable understanding complex data scientist's workflow, exploring different design options based on various use cases, and building detailed interaction and pixel specs. You will also be crafting a design system for integrating consistent, efficient components across our product portfolio.",
  'last_updated' => DateTime.new(2019,3,27,0,0,0)
  })
lead4.save

action5 = Action.new({
  'status_id' => status3.id,
  'lead_id' => lead4.id,
  'date_completed' => DateTime.new(2019,3,13,0,0,0),
  'summary' => 'Application submitted',
  'completed' => true
  })
action5.save

action6 = Action.new({
  'status_id' => status10.id,
  'lead_id' => lead4.id,
  'date_completed' => DateTime.new(2019,3,27,0,0,0),
  'summary' => 'Try again next time',
  'completed' => true
  })
action6.save

###LEAD 5
lead5 = Lead.new({
  'company_name' => 'LightningID',
  'name' => 'UX Designer',
  'link' => 'https://uk.linkedin.com/',
  'summary' => "About You

You probably have about 3-4 years' experience in UX and are looking to take your career to the next level.
You'll need demonstrable experience carrying out user research and testing, as well as interpreting analytics and other data. You'll also need a solid understanding of accessibility standards and agile development. If you've worked in a digital agency before, all the better.
You'll Also Need To Be: enthusiastic and motivated, with an appetite for learning a great communicator and collaborator unafraid to ask questions adept at solving problems organised and good at prioritising work focused, with sharp attention to detail passionate about improving outcomes for clients and their users.
About The Role: As a UX designer at Storm, you'll be part of our creative team at our modern offices in historic Leith. The role will also involve time out of the office, consulting with users and stakeholders in locations across Scotland and the rest of the UK. You'll conduct user research and testing, working collaboratively within our project teams to ensure that user-centred design is core to what we do.
What you'll do Here Are Some Examples To Give You a Flavour Of What You'll Do: You'll have a pretty impressive and varied set of responsibilities. develop user research plans undertake qualitative research and analysis, including user interviews, focus groups and ethnographic research undertake quantitative research including questionnaires and data analysis engage with stakeholders to understand their business objectives plan and facilitate rapid design workshops and sprint sessions sketch, prototype and wireframe to help communicate your ideas conduct usability and accessibility test sessions juggle multiple projects and adapt to changing priorities and tight schedules promote the value of user-centred design, both internally and externally contribute to project proposals by providing advice on UX strategy and activities maintain a high awareness of user experience best practice and trends.",
  'last_updated' => DateTime.new(2019,3,26,0,0,0)
  })
lead5.save
