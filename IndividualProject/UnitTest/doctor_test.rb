require 'test/unit'
require 'D:\RubyProject\IndividualProject\Models\doctor.rb'

class DoctorTest < Test::Unit::TestCase
  def test_initialize_with_required_fields
    doctor = Doctor.new(id: 1, last_name: 'Smith', first_name: 'John', patronymic: 'Doe', specialty: 'Cardiology')

    assert_equal(1, doctor.id)
    assert_equal('Smith', doctor.last_name)
    assert_equal('John', doctor.first_name)
    assert_equal('Doe', doctor.patronymic)
    assert_equal('Cardiology', doctor.specialty)
    assert_nil(doctor.qualification)
  end

  def test_initialize_with_optional_qualification
    doctor = Doctor.new(id: 1, last_name: 'Smith', first_name: 'John', patronymic: 'Doe', specialty: 'Cardiology', qualification: 'MD')

    assert_equal('MD', doctor.qualification)
  end

  def test_initialize_missing_required_fields
    assert_raises(ArgumentError) do
      Doctor.new(id: 1, last_name: 'Smith', first_name: 'John', specialty: 'Cardiology')
    end
  end

  def test_get_light
    patient = Doctor.new(
      id: 1,
      last_name: 'Smith',
      first_name: 'John',
      patronymic: 'Doe',
      specialty: 'gastrolog'
    )

    light = patient.get_light

    assert_instance_of(DoctorLight, light)
    assert_equal(1, light.id)
    assert_equal('Smith J.D.', light.full_name)
    assert_equal('gastrolog', light.specialty)
  end

  def test_id_invalid_type
    assert_raises(ArgumentError) do
      Doctor.new(id: '1', last_name: 'Smith', first_name: 'John', patronymic: 'Doe', specialty: 'Cardiology')
    end
  end

  def test_last_name_invalid_format
    assert_raises(ArgumentError) do
      Doctor.new(id: 1, last_name: 'Smith1', first_name: 'John', patronymic: 'Doe', specialty: 'Cardiology')
    end
  end

  def test_first_name_invalid_format
    assert_raises(ArgumentError) do
      Doctor.new(id: 1, last_name: 'Smith', first_name: 'John1', patronymic: 'Doe', specialty: 'Cardiology')
    end
  end

  def test_patronymic_invalid_format
    assert_raises(ArgumentError) do
      Doctor.new(id: 1, last_name: 'Smith', first_name: 'John', patronymic: 'Doe1', specialty: 'Cardiology')
    end
  end

  def test_to_s_without_qualification
    doctor = Doctor.new(id: 1, last_name: 'Smith', first_name: 'John', patronymic: 'Doe', specialty: 'Cardiology')

    expected_string = "Smith John Doe Cardiology"
    assert_equal(expected_string, doctor.to_s)
  end

  def test_to_s_with_qualification
    doctor = Doctor.new(id: 1, last_name: 'Smith', first_name: 'John', patronymic: 'Doe', specialty: 'Cardiology', qualification: 'MD')

    expected_string = "Smith John Doe Cardiology MD"
    assert_equal(expected_string, doctor.to_s)
  end
end
