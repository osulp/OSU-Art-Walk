namespace :jetty do
  desc "Configures Jetty"
  task :config do
    FileUtils.rm_rf "jetty/solr/blacklight-core-test", :verbose => true
    FileUtils.mkdir_p "jetty/solr/blacklight-core-test", :verbose => true
    FileUtils.cp_r "jetty/solr/blacklight-core/.", "jetty/solr/blacklight-core-test/", :verbose => true
    FileUtils.rm_rf "jetty/solr/blacklight-core-test/data", :verbose => true
    FileList['config/solr/*'].each do |f|
      cp("#{f}","jetty/solr/blacklight-core/conf/", :verbose => true)
      cp("#{f}","jetty/solr/blacklight-core-test/conf/", :verbose => true)
    end
  end
end
