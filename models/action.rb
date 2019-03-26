class Action
  attr_reader :id, :status_id, :due_date, :summary

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @lead_id = options['lead_id'].to_i if options['lead_id']
    @status_id = options['status_id'].to_i if options['status_id']
    @due_date = Date::strptime(options['due_date'].to_s, "%Y-%m-%d")
    @summary = options['summary']
    @completed = options['completed']
  end

  def save()
    sql = 'INSERT INTO actions (status_id, lead_id, due_date, summary, completed) VALUES ($1, $2, $3, $4, $5) RETURNING id'
    values = [@status_id, @lead_id, @due_date, @summary, @completed]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE actions SET (status_id, lead_id, due_date, summary, completed) = ($1, $2, $3, $4, $5) WHERE id = $5'
    values = [@status_id, @lead_id, @due_date, @summary, @completed, @id]
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

  def status()
    sql = 'SELECT * FROM status WHERE id = $1'
    values = [@status_id]
    result = SqlRunner.run(sql, values).first
   return Company.new(result)
  end

  def lead()
    sql = 'SELECT * FROM lead WHERE id = $1'
    values = [@lead_id]
    result = SqlRunner.run(sql, values).first
   return Company.new(result)
  end
end
