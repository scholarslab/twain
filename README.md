# Twain in His Times

This is the dockerized version of the website. It should contain all of the
same functionality, since it was static files except for the Solr search.

The Solr search functionality is retained with the use of a docker.

## Reverse Proxy Set up

There is an nginx container that acts as a proxy to the PHP/Apache container
(which serves the static content and runs the solr search page), and the Solr
container. All traffic hits the nginx container first, which then sends all
requests to the PHP/Apache container (twain), unless the URL has "solr", then
all requests are sent to the Solr container (twain_solr).

This allows us to have the domain name behind SSL.

## Files

```
├── Dockerfile            Build the PHP/Apache container with the solr module
├── content               All the static files
├── docker-compose.yml    The nginx proxy, PHP/Apache, and Solr containers
├── load-data             Script to properly set up the Solr container, load it
with data, and set it up for SSL
├── managed-schema        Solr config for all the field names
├── nginx.conf            Nginx proxy settings
├── schema.xml            The old Solr Schema file from the old server. Here
for preservation purposes.
├── solr.in.sh            Solr config file that allows serving over SSL
├── twain.json            The Solr data
└── web.xml               Solr config file that allows searching only
```


