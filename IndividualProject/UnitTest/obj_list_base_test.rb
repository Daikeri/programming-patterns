require 'test/unit'
require 'D:\RubyProject\IndividualProject\Manipulators\obj_list_base.rb'
require 'D:\RubyProject\IndividualProject\Models\doctor.rb'

class ObjListBaseTest < Test::Unit::TestCase
  def setup
    @doctors = [
      Doctor.new(id: 1, last_name: 'Smith', first_name: 'John', patronymic: 'Doe', specialty: 'Cardiology'),
      Doctor.new(id: 2, last_name: 'Johnson', first_name: 'Jane', patronymic: 'Smith', specialty: 'Dermatology'),
      Doctor.new(id: 3, last_name: 'Williams', first_name: 'David', patronymic: 'Brown', specialty: 'Orthopedics')
    ]
    @obj_list = ObjListBase.new(@doctors)
  end

  def test_initialize
    assert_equal(@doctors, @obj_list.instance_variable_get(:@arr).map(&:last))
    assert_equal([], @obj_list.instance_variable_get(:@selection))
    assert_equal([], @obj_list.instance_variable_get(:@subscribers))
  end

  def test_arr=
    new_doctors = [
      Doctor.new(id: 4, last_name: 'Anderson', first_name: 'Sarah', patronymic: 'Clark', specialty: 'Gynecology'),
      Doctor.new(id: 5, last_name: 'Taylor', first_name: 'Michael', patronymic: 'Johnson', specialty: 'Pediatrics')
    ]
    @obj_list.arr = new_doctors

    assert_equal(new_doctors, @obj_list.instance_variable_get(:@arr).map(&:last))
  end

  def test_select
    @obj_list.select(2)
    @obj_list.select(3)

    assert_equal([2, 3], @obj_list.instance_variable_get(:@selection))
  end

  def test_get_selected
    @obj_list.select(1)
    @obj_list.select(3)

    assert_equal([@doctors[0].id, @doctors[2].id], @obj_list.get_selected)
  end

  def test_clear_selected
    @obj_list.select(1)
    @obj_list.select(2)

    @obj_list.clear_selected

    assert_equal([], @obj_list.instance_variable_get(:@selection))
  end

  def test_subscribe
    subscriber = Object.new

    @obj_list.subscribe(subscriber)

    assert_equal([subscriber], @obj_list.instance_variable_get(:@subscribers))
  end

  def test_unsubscribe
    subscriber = Object.new
    @obj_list.instance_variable_set(:@subscribers, [subscriber])

    @obj_list.unsubscribe(subscriber)

    assert_equal([], @obj_list.instance_variable_get(:@subscribers))
  end
end
