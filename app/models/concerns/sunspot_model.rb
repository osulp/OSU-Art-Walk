module SunspotModel
  extend ActiveSupport::Concern
  included do
    include SunspotAutoIndex
  end

  def document_id
    Sunspot::Adapters::InstanceAdapter.adapt(self).index_id
  end
end
