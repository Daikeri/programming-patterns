require_relative 'laboratory_work_folder'
require 'D:\RubyProject\DoneApp\SourceManagement\Adapters\db_adapter_for_lw.rb'

adapter = DBAdapterForLW.new
folder = LaboratoryWorkFolder.new(adapter)

#print folder.get_by_number(10)
#print folder.get_lw_count
#folder.delete_by_number(10)
#folder.append(LaboratoryWork.from_hash({number:10, name:'Pattern', date_of_issue:"28.05.2009"}))
#lw = LaboratoryWork.from_hash({number:10, name:'Инфобез', date_of_issue:"28.05.2009"})
#folder.replace_by_number(1, lw)
