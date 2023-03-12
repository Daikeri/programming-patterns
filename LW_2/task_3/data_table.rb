
class DataTable
  def initialize(source_array)
    @arr = []
    count_attr = 1
    source_array.each do |obj|
      temp = [count_attr]
      field = obj.instance_variables
      field.map! { |sym| sym.to_s.gsub(/@/,'') }
      field.select! { |el| el != 'id' }
      field.each { |proc| temp.push(obj.instance_eval(proc)) }
      count_attr += 1
      @arr.push(temp)
    end
  end

  def get(i,j)
    @arr[i][j]
  end

  def n_rows
    @arr.size
  end

  def n_columns
    @arr[0].size
  end
end
