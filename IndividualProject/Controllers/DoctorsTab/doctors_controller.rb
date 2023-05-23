require 'D:\RubyProject\IndividualProject\Manipulators\obj_list_doctor.rb'
require 'D:\RubyProject\IndividualProject\DBSystem\db_adapter.rb'
require 'D:\RubyProject\IndividualProject\Manipulators\clinic_journal.rb'

class DoctorsController

  attr_reader :clinic_journal, :obj_list

  def initialize(view)
    @view = view
    @obj_list = ObjListDoctor.new([])
    @obj_list.subscribe(@view)
  end

  def on_doctors_view_created
    adapter = DBAdapter.new(:doctors)
    @clinic_journal = ClinicJournal.new(adapter)
  end

  def refresh_data
    @clinic_journal.get_all(@obj_list)
    @obj_list.notify
  end
end
