class Tweet
  attr_reader :username, :message, :id
  # @@all = []

  def initialize(params)
    @username = params['username']
    @message = params['message']
    @id = params['id']
  end


  def self.all
    sql = <<-SQL
      SELECT * FROM tweets
    SQL

    DB[:conn].execute(sql).map{|row| self.format_sql(row)}
  end

  def self.create(params)
    sql = <<-SQL
      INSERT INTO tweets (username, message) VALUES(?, ?)
    SQL
    DB[:conn].execute(sql, params['username'], params['message'])
    self.last
  end

  def self.last
    sql = <<-SQL
      SELECT * FROM tweets ORDER BY id DESC LIMIT 1
    SQL

    response = DB[:conn].execute(sql)[0]
    self.format_sql(response)
  end

  def self.find(id)
    sql = <<-SQL
      SELECT * FROM tweets WHERE id = (?)
    SQL

    response = DB[:conn].execute(sql, id)[0]
    self.format_sql(response)
  end

  def self.format_sql(params)
    Tweet.new(params)
  end

  def update(message)
    sql = <<-SQL
      UPDATE tweets SET message = (?) WHERE id = (?)
    SQL

    DB[:conn].execute(sql, message, self.id)
    Tweet.find(self.id)
  end

  def delete
    sql = <<-SQL
      DELETE FROM tweets WHERE id = (?)
    SQL

    DB[:conn].execute(sql, self.id)
    puts "Successfully Deleted"
  end


end
