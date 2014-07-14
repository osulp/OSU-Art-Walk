RSpec.configure do |config|
  config.before(:each) do
    Blacklight.solr.delete_by_query '*:*'
    Blacklight.solr.commit
  end
end