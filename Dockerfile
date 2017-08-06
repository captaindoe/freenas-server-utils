FROM httpd:alpine

COPY apache2/conf/httpd.conf /usr/local/apache2/conf/
COPY apache2/public-html/* /usr/local/apache2/htdocs/
COPY apache2/cgi-bin/* /usr/local/apache2/cgi-bin/

RUN apk --no-cache add curl 

EXPOSE 8080
