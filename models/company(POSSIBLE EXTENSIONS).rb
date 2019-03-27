require_relative('../db/sql_runner.rb')

class Company
  attr_reader :id, :name, :industry, :contact, :summary

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @industry = options['industry']
    @contact = options['contact']
    @summary = options['summary']
  end

  def save()
    sql = 'INSERT INTO companies (name, industry, contact, summary) VALUES ($1, $2, $3, $4) RETURNING id'
    values = [@name, @industry, @contact, @summary]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE companies SET (name, industry, contact, summary) = ($1, $2, $3, $4) WHERE id = $5'
    values = [@name, @industry, @contact, @summary, @id]
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

  def self.find_by_name(name)
    sql = "SELECT * FROM companies WHERE name = $1"
    values = [name]
    result = SqlRunner.run(sql, values).first
    return Company.new(result) if result
  end

  def self.company_by_name(name)
    company = Company.find_by_name(name)
    if company != nil
      return company.id
    else
      company = Company.new({'name' => name})
      company.save()
      return company.id
    end
  end

  def leads()
    sql = 'SELECT * FROM leads WHERE company_id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|hash| Company.new(hash)}
  end

end
