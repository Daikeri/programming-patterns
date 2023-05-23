require 'D:\RubyProject\IndividualProject\View\DoctorsTab\doctors_view.rb'
require 'D:\RubyProject\IndividualProject\View\PatientsTab\patients_view.rb'
require 'D:\RubyProject\IndividualProject\View\TreatmentsTab\treatments_view.rb'
require 'glimmer-dsl-libui'


class MainView
  include Glimmer

  attr_reader :doctors_view, :patients_view, :treatments_view
  def initialize
    @doctors_view = DoctorsView.new(self)
    @patients_view = PatientsView.new(self)
    @treatments_view = TreatmentsView.new(self)
  end

  def display
    @main_window = window('Платная клиника', 1400, 600) {
      margined true
      tab {
        @doctors_view.create
        @patients_view.create
        @treatments_view.create
      }
    }
    @main_window.show
  end
end

MainView.new.display
