require_relative('../db/sql_runner.rb')
require_relative('./status.rb')
require_relative('./action.rb')
require_relative('./lead.rb')

require 'pry-byebug'

class ActionLog
  attr_accessor :lead_id, :status_id, :date_completed, :summary
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @status_id = options['status_id'].to_i if options['status_id']
    @lead_id = options['lead_id'].to_i if options['lead_id']
    @date_completed = Date::strptime(options['date_completed'].to_s, "%Y-%m-%d") if options['date_completed']
    @summary = options['summary']
  end

  def save()
    @date_completed = Date.today
    sql = 'INSERT INTO actions_log (lead_id, status_id, date_completed, summary) VALUES ($1, $2, $3, $4) RETURNING id'
    values = [@lead_id, @status_id, @date_completed, @summary]
    @id  = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update()
    sql = 'UPDATE actions_log SET (lead_id, status_id, date_completed, summary) = ($1, $2, $3, $4) WHERE id = $5'
    values = [@lead_id, @status_id, @date_completed, @summary, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM actions_log WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM actions_log'
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = 'SELECT * FROM actions_log WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values).first
    return ActionLog.new(result)
  end

  def status()
    sql = 'SELECT * FROM status WHERE id = $1'
    values = [@status_id]
    result = SqlRunner.run(sql, values).first
    return Status.new(result)
  end

  def self.archive(old_action)
    logged_action = ActionLog.new({
      'status_id' => old_action.status_id,
      'summary' => old_action.summary,
      'lead_id' => old_action.lead.id
      })
    logged_action.save
  end

  def word_date()
    date = self.date_completed
    return "#{date.strftime("%B %d, %Y")}"
  end
end
