require('date')
require ('time_difference')

p Date.today
p Date.new(2018,06,12)

date =  TimeDifference.between(Date.new(2019,06,12), Date.today)

p date
