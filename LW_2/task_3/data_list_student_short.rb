require_relative 'data_list.rb'
require_relative 'data_table.rb'

class DataListStudentShort < DataList
  def get_names
    acc = []
    count_attr = 1
    @arr.each do |obj|
      temp = obj.instance_variables
      temp.map! { |sym| sym.to_s.gsub(/@/,'') }
      temp.select! { |el| el != 'id' }
      temp.unshift(count_attr)
      acc.push(temp)
      count_attr += 1
    end
    acc
  end

  def get_data
    DataTable.new(@arr)
  end

end

