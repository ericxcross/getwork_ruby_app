require_relative('../db/sql_runner.rb')
require_relative('./status.rb')
require_relative('./lead.rb')

class Action
  attr_reader :id, :status_id, :due_date, :summary

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @status_id = options['status_id'].to_i if options['status_id']
    @due_date = Date::strptime(options['due_date'].to_s, "%Y-%m-%d") if options['due_date']
    @summary = options['summary']
  end

  def save()
    sql = 'INSERT INTO actions (status_id, due_date, summary) VALUES ($1, $2, $3) RETURNING id'
    values = [@status_id, @due_date, @summary]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE actions SET (status_id, due_date, summary) = ($1, $2, $3) WHERE id = $4'
    values = [@status_id, @due_date, @summary, @id]
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
    return Status.new(result)
  end

  def lead()
    sql = 'SELECT * FROM leads WHERE action_id = $1'
    values = [@id]
    result = SqlRunner.run(sql, values).first
   return Lead.new(result)
  end

  def self.default()
    default_action = Action.new({
      'status_id' => Status.default_id
      })
    default_action.save
    return default_action.id
  end

  def self.find(id)
    sql = 'SELECT * FROM actions WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Action.new(result)
  end

  def word_date()
    date = self.due_date
    if date != nil
      if date > Date.today
        return "Due: #{date.strftime("%B %d, %Y")}"
      elsif date == Date.today
        return "Due Today"
      elsif date < Date.today
        return "<strong>Overdue: #{date.strftime("%B %d, %Y")}</strong>"
      end
    end
    return
  end

end
