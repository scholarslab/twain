<?php

define('SOLR_SERVER_HOSTNAME', 'twain.lib.virginia.edu');
define('SOLR_SERVER_PORT', 9988);

$options = array
(
        'hostname' => SOLR_SERVER_HOSTNAME,
        'port'     => SOLR_SERVER_PORT,
        'path'     => 'solr/tcore'
);

$client = new SolrClient($options);

$query = new SolrQuery('*:*');

$collapseFunction = new SolrCollapseFunction('manu_id_s');

$collapseFunction
->setSize(2)
->setNullPolicy(SolrCollapseFunction::NULLPOLICY_IGNORE);

$query
->collapse($collapseFunction)
->setRows(4);

$queryResponse = $client->query($query);

$response = $queryResponse->getResponse();

print_r($response);
?>
