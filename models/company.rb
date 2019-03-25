require_relative('../db/sql_runner.rb')

class Company
  attr_reader :id, :name, :industry, :date_added, :contact, :info

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @industry = options['industry']
    @date_added = options['date_added'] if options['date_added']
    @contact = options['contact']
    @info = options['info']
  end

  def save()
    sql = 'INSERT INTO companies (name, industry, contact, info) VALUES ($1, $2, $3, $4) RETURNING id'
    values = [@name, @industry, @contact, @info]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE companies SET (name, industry, contact, info) = ($1, $2, $3, $4) WHERE id = $5'
    values = [@name, @industry, @contact, @info, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM companies WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM companies'
    SqlRunner.run(sql)
  end

  def self.all() #returns companies in alphabetical order
    sql = 'SELECT * FROM companies ORDER BY name ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Company.new(hash)}
  end

  def jobs()
    sql = 'SELECT * FROM leads WHERE company_id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|hash| Company.new(hash)}
  end

end
