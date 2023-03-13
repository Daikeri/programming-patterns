require_relative 'data_list.rb'
require_relative 'data_table.rb'

class DataListStudentShort < DataList
  attr_reader :data, :names

  def initialize(source_array)
    validate_array(source_array)
    super
    @data = DataTable.new(@arr)
    set_names
  end

  def arr=(source_array)
    validate_array(source_array)
    @arr = source_array
    @data = DataTable.new(@arr)
    nil
  end

  private

  def validate_array(array)
    message = 'Массив может содержать только объекты типа StudentShort!'
    array.each { |obj| obj.is_a?(StudentShort) ? obj : raise(ArgumentError, message) }
  end

  def set_names
    source = @arr[0]

    field = source.instance_variables
    field.map! { |sym| sym.to_s.gsub(/@/,'') }
    field.select! { |el| el != 'id' }

    result = []
    count_attr = 1
    field.each do |attr|
      result.push([count_attr, attr])
      count_attr += 1
    end

    @names = result
  end
end

