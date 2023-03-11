
class DataTable
  def initialize(source_array)
    @arr = []
    source_array.each do |obj|
      temp = [obj.id]
      temp += (obj.get_full_info.split(', '))
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
    @arr.size[0]
  end
end
