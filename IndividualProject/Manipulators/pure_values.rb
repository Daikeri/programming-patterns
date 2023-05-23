

class PureValues
  def initialize(source_array)
    @arr = []
    source_array.each do |obj|
      temp = [obj[0]]
      field = obj[1].instance_variables
      field.select! { |attr| !attr.to_s.end_with?('id') }
      field.map! { |sym| sym.to_s.gsub(/@/,'') }
      field.each { |proc| temp << obj[1].instance_eval(proc) }
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
