require_relative('../db/sql_runner.rb')
require_relative('./action.rb')
require_relative('./status.rb')

require('pry-byebug')

class Lead
  attr_accessor :last_updated, :name, :company_name, :link, :summary
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']

    @last_updated = options['last_updated'] if options['last_updated']

    @company_name = options['company_name']
    @name = options['name']
    @link = options['link']
    @summary = options['summary']
    @archive = options['archive']
  end

  def save()
    @last_updated = DateTime.now
    sql = 'INSERT INTO leads (company_name, name, link, last_updated, summary, archive) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id'
    values = [@company_name, @name, @link, @last_updated, @summary, @archive]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    @last_updated = DateTime.now
    sql = 'UPDATE leads SET (company_name, name, link, summary, archive, last_updated) = ($1, $2, $3, $4, $5, $6) WHERE id = $7'
    values = [@company_name, @name, @link, @summary, @archive, @last_updated, @id]
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
    sql = 'SELECT * FROM leads ORDER BY name DESC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

  # def self.all_by_due_date
  #   sql = 'SELECT * FROM leads'
  #   result = SqlRunner.run(sql)
  #   leads = result.map{|hash| Lead.new(hash)}
  #   sorted_leads = leads.sort_by{|lead| lead.primary_action.date_completed}
  #   return sorted_leads
  # end

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

  def self.find(id)
    sql = 'SELECT * FROM leads WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Lead.new(result)
  end

  def actions()
    sql = 'SELECT * FROM actions WHERE lead_id = $1 ORDER BY completed DESC, date_completed DESC'
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|hash| Action.new(hash)}
  end

  def primary_action() #lead.primaryaction
    actions = actions()
    first_action = actions.last
    #return default if no actions exist or most recent action is completed
    if first_action == nil || first_action.completed == 't'
      first_action = Action.new({
        "status_id" => Status.default_id,
        "lead_id" => @id
        })
    end
    # end
     #return first action
    return first_action
  end

  def word_date()
    date_string = self.last_updated
    date = DateTime.parse(date_string)
    return date.strftime("%B %d, %Y")
  end

end
