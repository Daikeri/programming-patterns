
class ClinicJournal
  def initialize(some_adapter)
    @adapter = some_adapter
  end

  def get_by_id(id)
    @adapter.get_by_id(id)
  end

  def append(obj)
    @adapter.append(obj)
  end

  def update_by_id(id, obj)
    @adapter.update_by_id(id, obj)
  end

  def delete_by_id(id)
    @adapter.delete_by_id(id)
  end

  def get_all(exist_obj_list=nil)
    @adapter.get_all(exist_obj_list)
  end

  def count_id
    @adapter.count_id
  end
end
