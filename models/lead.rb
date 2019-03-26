require_relative('../db/sql_runner.rb')
require_relative('./company.rb')
require_relative('./status.rb')

class Lead
  attr_accessor :company_id, :status_id, :date_added, :last_updated, :name, :link, :summary, :comments
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @company_id = options['company_id'].to_i if options['company_id']
    @action_id = options['action_id'].to_i if options['action_id']
    @date_added = options['date_added'] if options['date_added']
    @last_updated = options['last_updated'] if options['last_updated']

    @name = options['name']
    @link = options['link']
    @summary = options['summary']
    @comments = options['comments']
  end


  def save()
    sql = 'INSERT INTO leads (company_id, status_id, name, link, summary, comments) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id'
    values = [@company_id, @status_id, @name, @link, @summary, @comments]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE leads SET (company_id, status_id, name, link, summary, comments) = ($1, $2, $3, $4, $5, $6) WHERE id = $7'
    values = [@company_id, @status_id, @name, @link, @summary, @comments, @id]
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
    sql = 'SELECT * FROM leads ORDER BY status_id DESC, name ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

  def self.all_by_letter() #returns leads in alphabetical order
    sql = 'SELECT * FROM leads ORDER BY name ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

  def self.all_by_last_updated() #returns leads in alphabetical order
    sql = 'SELECT * FROM leads ORDER BY date ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Lead.new(hash)}
  end

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

  def status()
    sql = 'SELECT * FROM status WHERE id = $1'
    values = [@status_id]
    result = SqlRunner.run(sql, values).first
   return Status.new(result)
  end


end
