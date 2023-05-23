require 'D:\RubyProject\IndividualProject\Manipulators\obj_list_treatment.rb'

class TreatmentsController

  attr_reader :clinic_journal, :obj_list

  def initialize(view)
    @view = view
    @obj_list = ObjListTreatment.new([])
    @obj_list.subscribe(@view)
  end

  def on_treatments_view_created
    adapter = DBAdapter.new(:treatments)
    @clinic_journal = ClinicJournal.new(adapter)
  end

  def refresh_data
    @clinic_journal.get_all(@obj_list)
    @obj_list.notify
  end
end
