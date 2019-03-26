require_relative('../db/sql_runner.rb')
require_relative('./company.rb')
require_relative('./action.rb')
require_relative('./status.rb')

require('pry-byebug')

class Lead
  attr_accessor :company_id, :action_id, :last_updated, :name, :link, :summary
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']

    @last_updated = Date::strptime(options['last_updated'].to_s, "%Y-%m-%d") if options['last_updated']

    @company_id = options['company_id'].to_i if options['company_id']
    @action_id = options['action_id'].to_i if options['action_id']

    @name = options['name']
    @link = options['link']
    @summary = options['summary']
  end

  def save()
    @last_updated = Date.today
    sql = 'INSERT INTO leads (company_id, action_id, name, link, last_updated, summary) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id'
    values = [@company_id, @action_id, @name, @link, @last_updated, @summary]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    @last_updated = Date.today
    sql = 'UPDATE leads SET (company_id, action_id, name, link, summary, last_updated) = ($1, $2, $3, $4, $5, $6) WHERE id = $7'
    values = [@company_id, @action_id, @name, @link, @summary, @last_updated, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM leads WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM leads'
    SqlRunner.run(sql)
  end

  def self.all_by_name() #returns leads in alphabetical order
    sql = 'SELECT * FROM leads ORDER BY name ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

  def self.all_by_due_date
    sql = 'SELECT leads.* FROM leads INNER JOIN actions ON actions.id = leads.action_id ORDER BY actions.due_date ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

  def self.all_by_status
    sql = 'SELECT leads.* FROM leads INNER JOIN actions ON actions.id = leads.action_id ORDER BY actions.status_id ASC, actions.due_date ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

  def self.all_by_update
    sql = 'SELECT * FROM leads ORDER BY last_updated ASC, id ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

  # def self.all_by_due_date() #returns leads in alphabetical order
  #   sql = 'SELECT * FROM leads ORDER BY name ASC'
  #   result = SqlRunner.run(sql)
  #   return result.map{|hash| Lead.new(hash)}
  # end

  def self.find(id)
    sql = 'SELECT * FROM leads WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Lead.new(result)
  end

  def company()
    sql = 'SELECT * FROM companies WHERE id = $1'
    values = [@company_id]
    result = SqlRunner.run(sql, values).first
   return Company.new(result)
  end

  def action()
    sql = 'SELECT * FROM actions WHERE id = $1'
    values = [@action_id]
    result = SqlRunner.run(sql, values).first
    return Action.new(result)
  end

  def action_status()
    sql = 'SELECT status.* FROM status INNER JOIN actions ON actions.status_id = status.id WHERE actions.id = $1'
    values = [@action_id]
    result = SqlRunner.run(sql, values).first
    return Status.new(result)
  end

  def action_date()
    sql = 'SELECT * FROM actions WHERE actions.id = $1'
    values = [@action_id]
    result = SqlRunner.run(sql, values).first
    date = Action.new(result).due_date
    if date > Date.today
      return "Due Date: #{date.strftime("%B %d %Y")}"
    elsif date == Date.today
      return "Due Today"
    elsif date < Date.today
      return "<strong>Overdue: #{date.strftime("%B %d %Y")}</strong>"
    end
  end

  def long_ago()
    return @last_updated.strftime("%B %d %Y")
    # if time_passed.day > 1
    #   return "over #{time_passed.day} days ago"
    # elsif time_passed.day == 1
    #   return "today"
    # elsif time_passed.month > 1
    #   return "over #{time_passed.month} months ago"
    # elsif time_passed.month == 1
    #   return "over 1 month ago"
    # elsif time_passed.year > 1
    #   return "over #{time_passed.year} years ago"
    # elsif time_passed.year == 1
    #   return "over 1 year ago"
    # end
  end

end
