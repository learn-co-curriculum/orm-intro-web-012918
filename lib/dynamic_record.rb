class DynamicRecord


  def self.set_attributes
    column_names.each do |col|
      attr_accessor(col.to_sym)
    end
  end

  def self.column_names
     DB[:conn].execute("PRAGMA table_info (#{table_name})").map do |col_info|
       col_info['name']
     end
  end

  def self.table_name
    self.to_s.downcase + 's'
  end

  def initialize(params)
    # {message: 'coffee', username: 'coffee_dad', id: 1}
    # self.username=(params['username'])
    # self.message=(params['message'])
    # self.id= params['id']

    params.each do |key, val|
      self.send("#{key}=", val)
    end
  end


  def self.all
    sql = <<-SQL
      SELECT * FROM #{self.table_name}
    SQL

    DB[:conn].execute(sql).map{|row| self.format_sql(row)}
  end

  def self.create(params)
    sql = <<-SQL
      INSERT INTO #{table_name} (#{column_names_for_insert}) VALUES(#{values_for_insert})
    SQL
    # binding.pry
    DB[:conn].execute(sql, column_names_array.map {|col| params[col]})
    self.last
  end

  def self.last
    sql = <<-SQL
      SELECT * FROM #{self.table_name} ORDER BY id DESC LIMIT 1
    SQL

    response = DB[:conn].execute(sql)[0]
    self.format_sql(response)
  end

  def self.find(id)
    sql = <<-SQL
      SELECT * FROM #{table_name} WHERE id = (?)
    SQL

    row = DB[:conn].execute(sql, id)[0]
    row ? self.format_sql(row) : nil
  end

  def self.format_sql(params)
    properties = params.reject do |k, v|
      k.is_a?(Integer)
    end
    self.new(properties)
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

  private

  def self.column_names_array
    self.column_names.reject { |col| col == "id"}
  end

  def self.column_names_for_insert
    self.column_names_array.join(', ')
  end

  def self.values_for_insert
    self.column_names_array.map {|col| '?' }.join(', ')
  end


end
