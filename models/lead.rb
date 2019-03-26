require_relative('../db/sql_runner.rb')
require_relative('./company.rb')
require_relative('./status.rb')

class Lead
  attr_accessor :company_id, :last_updated, :name, :link, :summary
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @last_updated = date.parse(options['last_updated']) if options['last_updated']

    @company_id = options['company_id'].to_i if options['company_id']
    @name = options['name']
    @link = options['link']
    @summary = options['summary']
  end


  def save()
    @last_updated = Date.today
    sql = 'INSERT INTO leads (company_id, name, link, last_updated, summary) VALUES ($1, $2, $3, $4, $5) RETURNING id'
    values = [@company_id, @name, @link, @last_updated, @summary]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    @last_updated = Date.today
    sql = 'UPDATE leads SET (company_id, name, link, summary, last_updated) = ($1, $2, $3, $4, $5) WHERE id = $6'
    values = [@company_id, @name, @link, @summary, @last_updated, @id]
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

  def self.all() #returns leads in alphabetical order
    sql = 'SELECT * FROM leads ORDER BY name ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

  def self.all_by_last_updated() #returns leads in alphabetical order
    sql = 'SELECT * FROM leads ORDER BY date ASC'
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
    sql = 'SELECT * FROM action WHERE id = $1 ORDER BY id DESC'
    values = [@action_id]
    result = SqlRunner.run(sql, values)
   return result.map{|hash| Lead.new(hash)}
  end


end
