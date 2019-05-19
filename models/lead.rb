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

  def self.all_by_status
    sql = 'SELECT leads.* FROM leads'
    result = SqlRunner.run(sql)
    leads_list = result.map{|hash| Lead.new(hash)}
    order = []
    for lead in leads_list
      key = [lead, lead.primary_action.status_id]
      order << key
    end
    sorted_leads = order.sort_by{|a,b| b}
    return sorted_leads.map{|element| element[0]}.reverse
  end

  def self.all_by_name() #returns leads in alphabetical order
    sql = 'SELECT leads.* FROM leads ORDER BY company_name ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

  def self.all_by_action_date
    sql = 'SELECT leads.* FROM leads'
    result = SqlRunner.run(sql)
    leads_list = result.map{|hash| Lead.new(hash)}
    order = []
    for lead in leads_list
      date = lead.primary_action.date_completed
      if date != nil
        converted_date = DateTime.parse(date)
      else
        converted_date = DateTime.new(2100)
      end
      key = [lead, converted_date]
      order << key
    end
    sorted_leads = order.sort_by{|a,b| b}
    return sorted_leads.map{|element| element[0]}.reverse
  end

  def self.all_by_update
    sql = 'SELECT leads.* FROM leads ORDER BY last_updated DESC'
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
    sql = 'SELECT * FROM actions WHERE lead_id = $1 ORDER BY completed DESC, id ASC'
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|hash| Action.new(hash)}
  end

  # Primary action checks which action has priority in the lead
  def primary_action()
    #Retrieve actions from above 
    actions = actions()
    first_action = actions.last
    #return default if no actions exist or most recent action is completed
    if first_action == nil
      first_action = Action.new({
        "status_id" => Status.no_actions,
        "lead_id" => @id
        })
    end
     #return first action
    return first_action
  end

  def word_date()
    date_string = self.last_updated
    date = DateTime.parse(date_string)
    return date.strftime("%B %d, %Y")
  end

end
