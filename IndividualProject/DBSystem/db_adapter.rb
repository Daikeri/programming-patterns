require_relative 'db_connection'
require 'D:\RubyProject\IndividualProject\DBSystem\Strategies\doctors_table.rb'
require 'D:\RubyProject\IndividualProject\DBSystem\Strategies\patients_table.rb'
require 'D:\RubyProject\IndividualProject\DBSystem\Strategies\treatments_table.rb'


class DBAdapter

  def initialize(table_sym)
    @db_connect = DBConnection.instance
    table_selection(table_sym)
  end

  def get_by_id(id)
    @specific_table.get_by_id(id)
  end

  def append(obj)
    @specific_table.append(obj)
  end

  def update_by_id(id, obj)
    @specific_table.update_by_id(id, obj)
  end

  def delete_by_id(id)
    @specific_table.delete_by_id(id)
  end

  def get_all(exist_obj_list=nil)
    @specific_table.get_all(exist_obj_list)
  end

  def get_all_id
    @specific_table.get_all_id
  end

  def count_id
    @specific_table.count_id
  end

  protected

  def table_selection(table)
    @specific_table = case table
    when :doctors
      DoctorsTable.new(@db_connect)
    when :patients
      PatientsTable.new(@db_connect)
    when :treatments
      TreatmentsTable.new(@db_connect)
    else raise(ArgumentError, 'Запрошенная таблица не найдена')
    end
  end
end
