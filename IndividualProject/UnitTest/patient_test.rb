require 'test/unit'
require 'D:\RubyProject\IndividualProject\Models\patient.rb'
require 'D:\RubyProject\IndividualProject\Models\patient_light.rb'

class PatientTest < Test::Unit::TestCase
  def test_initialization
    patient = Patient.new(
      id: 1,
      last_name: 'Smith',
      first_name: 'John',
      patronymic: 'Doe',
      age: 35
    )

    assert_equal(1, patient.id)
    assert_equal('Smith', patient.last_name)
    assert_equal('John', patient.first_name)
    assert_equal('Doe', patient.patronymic)
    assert_equal(35, patient.age)
  end

  def test_invalid_id
    assert_raises(ArgumentError) do
      Patient.new(
        id: 'abc',
        last_name: 'Smith',
        first_name: 'John',
        patronymic: 'Doe',
        age: 35
      )
    end
  end

  def test_invalid_last_name
    assert_raises(ArgumentError) do
      Patient.new(
        id: 1,
        last_name: '123',
        first_name: 'John',
        patronymic: 'Doe',
        age: 35
      )
    end
  end

  def test_invalid_first_name
    assert_raises(ArgumentError) do
      Patient.new(
        id: 1,
        last_name: 'Smith',
        first_name: '123',
        patronymic: 'Doe',
        age: 35
      )
    end
  end

  def test_invalid_patronymic
    assert_raises(ArgumentError) do
      Patient.new(
        id: 1,
        last_name: 'Smith',
        first_name: 'John',
        patronymic: '123',
        age: 35
      )
    end
  end

  def test_invalid_age
    assert_raises(ArgumentError) do
      Patient.new(
        id: 1,
        last_name: 'Smith',
        first_name: 'John',
        patronymic: 'Doe',
        age: -5
      )
    end
  end

  def test_get_light
    patient = Patient.new(
      id: 1,
      last_name: 'Smith',
      first_name: 'John',
      patronymic: 'Doe',
      age: 35
    )

    light = patient.get_light

    assert_instance_of(PatientLight, light)
    assert_equal(1, light.id)
    assert_equal("Smith J.D.", light.full_name)
    assert_equal(35, light.age)
  end

  def test_to_s
    patient = Patient.new(
      id: 1,
      last_name: 'Smith',
      first_name: 'John',
      patronymic: 'Doe',
      age: 35
    )

    assert_equal('1 Smith John Doe 35', patient.to_s)
  end
end
