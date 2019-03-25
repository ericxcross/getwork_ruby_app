require ('../sql_runner.rb')

class Status
  attr_reader :name, :color, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @color = options['color']
  end

  def save()
    sql = 'INSERT INTO status (name, color) VALUES ($1, $2)'
    values = [@name, @color]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE status SET (name, color) = ($1, $2) WHERE id = $3'
    values = [@name, @color, @id]
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

  def self.all()
    sql = 'SELECT * FROM status'
    result = SqlRunner.run(sql)
    return result.map{|hash| Status.new(hash)}
  end

  def jobs()
    sql = 'SELECT * FROM leads WHERE status_id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|hash| Status.new(hash)}
  end
end
