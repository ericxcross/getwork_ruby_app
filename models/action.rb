require_relative('../db/sql_runner.rb')
require_relative('./status.rb')
require_relative('./lead.rb')

class Action
  attr_reader :id
  attr_accessor :status_id, :lead_id, :date_due, :date_completed, :completed, :summary

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @status_id = options['status_id'].to_i if options['status_id']
    @lead_id = options['lead_id'].to_i if options['lead_id']

    @date_completed = options['date_completed'] if options['date_completed']

    @completed = options['completed']
    @summary = options['summary']
  end

  def save()
    sql = 'INSERT INTO actions (status_id, lead_id, date_completed, completed, summary) VALUES ($1, $2, $3, $4, $5) RETURNING id'
    values = [@status_id, @lead_id, @date_completed, @completed, @summary]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE actions SET (status_id, lead_id, date_completed, completed, summary) = ($1, $2, $3, $4, $5) WHERE id = $6'
    values = [@status_id, @lead_id, @date_completed, @completed, @summary, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM actions WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM actions'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = 'SELECT * FROM actions'
    result = SqlRunner.run(sql)
    return result.map{|hash| Action.new(hash)}
  end

  def self.find(id)
    sql = 'SELECT * FROM actions WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Action.new(result)
  end

  def status()
    sql = 'SELECT * FROM status WHERE id = $1'
    values = [@status_id]
    result = SqlRunner.run(sql, values).first
    return Status.new(result)
  end



# Function to retrieve date in a string format
  def word_date()
    #Find date action was completed (from database using date_completed function)
    date_string = self.date_completed
    #Return if date does not exist
    return if date_string == nil
    date_string = self.date_completed
    #Parse date into DATETIME format
    date = DateTime.parse(date_string)
    #if the action has not been completed return string anouncing when the action
    #will occur. Logic needed to check if the date is upcoming or overdue.
    if @completed == 'f'
      if date.to_date > Date.today
        return "Upcoming<br>#{date.strftime("%B %e, %Y")}"
      elsif date.to_date == Date.today
        return "Upcoming<br>Today"
      elsif date.to_date < Date.today
        return "<strong>Overdue<br>#{date.strftime("%B %e, %Y")}</strong>"
      end
    #if action has already been completed, return the date completed.
    else
      return "#{date.strftime("%B %e, %Y")}"
    end
  end

end
