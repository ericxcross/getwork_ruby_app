require_relative('../db/sql_runner.rb')

class Status
  attr_reader :name, :color, :id, :archive

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @color = options['color']
    @archive = options['archive']
  end

  def save()
    sql = 'INSERT INTO status (name, color, archive) VALUES ($1, $2, $3) RETURNING id'
    values = [@name, @color, @archive]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE status SET (name, color, archive) = ($1, $2, $3) WHERE id = $4'
    values = [@name, @color, @archive, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM status WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM status'
    SqlRunner.run(sql)
  end

  def self.all() #order by ID asc (in backend all status are created in order)
    sql = 'SELECT * FROM status ORDER BY id ASC'
    result = SqlRunner.run(sql)
    return result.map{|hash| Status.new(hash)}
  end

  def self.default_id()
    sql = 'SELECT * FROM status WHERE id = (SELECT MAX(id) FROM status)'
    result = SqlRunner.run(sql).first
    return Status.new(result).id
  end
end
