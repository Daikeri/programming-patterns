require 'D:\RubyProject\IndividualProject\Manipulators\obj_list_patient.rb'

class PatientsController

  attr_reader :clinic_journal, :obj_list

  def initialize(view)
    @view = view
    @obj_list = ObjListPatient.new([])
    @obj_list.subscribe(@view)
  end

  def on_patients_view_created
    adapter = DBAdapter.new(:patients)
    @clinic_journal = ClinicJournal.new(adapter)
  end

  def refresh_data
    @clinic_journal.get_all(@obj_list)
    @obj_list.notify
  end
end
