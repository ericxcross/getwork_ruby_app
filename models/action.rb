class Action
  attr_reader :id, :status_id, :action_date, :summary

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @status_id = options['status_id'].to_i if options['status_id']
    @due_date = options['due_date']
    @summary = options['summary']
  end

  def save()
    sql = 'INSERT INTO actions (status_id, due_date, summary) VALUES ($1, $2, $3) RETURNING id'
    values = [@status_id, @action_date, @summary]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE actions SET (status_id, due_date, summary) = ($1, $2, $3) WHERE id = $4'
    values = [@status_id, @action_date, @summary, @id]
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
end
