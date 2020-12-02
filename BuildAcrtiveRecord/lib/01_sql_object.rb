require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns unless @columns.nil?

    array = DBConnection.execute2(<<-SQL)
    Select * from #{self.table_name}
    limit 0
    SQL

    @columns = array[0].map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |column|
      self.define_method("#{column}") do
        self.instance_variable_get(:"@#{column}")
      end

      self.define_method("#{column}=") do |val|
        self.instance_variable_set("@#{column}", val)
        @attributes[column] = val
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name ||= self.name.tableize
    
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
