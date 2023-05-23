require_relative 'pure_values'

class ObjListBase

  def initialize(array)
    raise(ArgumentError, 'Объекты массива должны иметь один тип!')unless valid_array_hook?(array)
    self.arr = array
    @selection = []
    @subscribers = []
  end

  def arr=(array)
    valid_array_hook?(array)
    @arr = []
    count_obj = 1
    array.each do |obj|
      @arr.push([count_obj, obj])
      count_obj += 1
    end
  end

  def select(number)
    @selection.push(number)
  end

  def get_selected
    acc = []
    @selection.each do |number|
      result = (@arr.find { |tuple| tuple[0] == number })
      acc.push(result[1].id)
    end
    acc
  end

  def clear_selected
    @selection = []
  end

  def pure_values
    PureValues.new(@arr)
  end

  def notify
    @subscribers.each { |sub| sub.update(self.pure_values) }
  end

  def subscribe(obj)
    @subscribers.push(obj)
  end

  def unsubscribe(sub_obj)
    @subscribers.delete(sub_obj)
  end

  protected

  def valid_array_hook?(array)
  end
end
