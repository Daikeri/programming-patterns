require 'test/unit'
require 'D:\RubyProject\IndividualProject\Models\treatment.rb'

class TreatmentTest < Test::Unit::TestCase
  def test_initialization
    treatment = Treatment.new(
      1, # id
      1, # doctor_id
      1, # patient_id
      'Diagnosis', # diagnosis
      '1556.89', # cost
      '01.01.2017' # treatment_date
    )

    assert_equal(1, treatment.id)
    assert_equal(1, treatment.doctor_id)
    assert_equal(1, treatment.patient_id)
    assert_equal('Diagnosis', treatment.diagnosis)
    assert_equal('1556.89', treatment.cost)
    assert_equal('01.01.2017', treatment.treatment_date)
  end

  def test_invalid_id
    assert_raises(ArgumentError) do
      Treatment.new(
        'abc', # invalid id
        1, # doctor_id
        1, # patient_id
        'Diagnosis',
        '100.00',
        '01.01.2023'
      )
    end
  end

  def test_invalid_cost
    assert_raises(ArgumentError) do
      Treatment.new(
        1,
        1,
        1,
        'Diagnosis',
        'abc', # invalid cost
        '01.01.2023'
      )
    end
  end

  def test_invalid_treatment_date
    assert_raises(ArgumentError) do
      Treatment.new(
        1,
        1,
        1,
        'Diagnosis',
        '100.00',
        '2023.01.01' # invalid treatment date
      )
    end
  end
end
