module SunspotAutoIndex
  extend ActiveSupport::Concern
  included do
    def solr_index(*args)
      super
      Sunspot.commit
    end
  end
end