#!/usr/bin/ruby

require '/sds/shared/deployer-lib/ruby/files_from_mdate'
require '/sds/shared/deployer-lib/ruby/solr_update'

HOST = 'http://localhost:8080'

mdate = ARGV[0].nil? ? nil : ARGV[0].to_sym
update = SolrUpdate.new(HOST + '/solr/twain')
update.index( File.join(File.dirname(__FILE__), 'add_docs', 'add_*.xml'), mdate)
