

class Treatment

  COST = /^(?:\d{1,3}(?:,\d{3})*|\d+)(?:\.\d{2})?$/
  DATE = /^(0[1-9]|[12]\d|3[01])\.(0[1-9]|1[0-2])\.(19\d\d|20\d\d|21\d\d|22\d\d|23\d\d)$/

  attr_reader :id, :doctor_id, :patient_id, :cost, :treatment_date
  attr_accessor :diagnosis

  def initialize(id:, doctor_id:, patient_id:, diagnosis:, cost:, treatment_date:)
    message = 'id, doctor_id, patient_id, diagnosis, cost, treatment_date - required fields!'
    raise(ArgumentError, message) unless id && doctor_id && patient_id && diagnosis && cost && treatment_date
    self.id = id
    self.doctor_id = doctor_id
    self.patient_id = patient_id
    self.diagnosis = diagnosis
    self.cost = cost
    self.treatment_date = treatment_date
  end

  def id=(val)
    msg = 'Полю id должно быть присвоено целочисленное значение'
    raise(ArgumentError, msg) unless val.is_a?(Integer)
    @id = val
  end

  def doctor_id=(val)
    msg = 'Полю doctor_id должно быть присвоено целочисленное значение'
    raise(ArgumentError, msg) unless val.is_a?(Integer)
    @doctor_id = val
  end

  def patient_id=(val)
    msg = 'Полю patient_id должно быть присвоено целочисленное значение'
    raise(ArgumentError, msg) unless val.is_a?(Integer)
    @patient_id = val
  end

  def cost=(val)
    msg = 'Неккоректный формат стоимости процедуры/консультации!'
    raise(ArgumentError, msg) unless val.match?(COST)
    @cost = val
  end

  def treatment_date=(val)
    msg = 'Неккоректный формат даты процедуры/консультации!'
    raise(ArgumentError, msg) unless val.match?(DATE)
    @treatment_date = val
  end
end
