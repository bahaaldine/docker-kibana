FROM java:8
MAINTAINER Bahaaldine Azarmi <baha@elastic.co>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y supervisor curl

# Kibana
RUN \
    curl -s https://download.elasticsearch.org/kibana/kibana/kibana-4.1.0-linux-x64.tar.gz | tar -C /opt -xz && \
    ln -s /opt/kibana-4.1.0-linux-x64 /opt/kibana && \
    sed -i 's/elasticsearch_url: .*/elasticsearch_url: http:\/\/elasticsearch:9200/' /opt/kibana/config/kibana.yml

ADD etc/supervisor/conf.d/kibana.conf /etc/supervisor/conf.d/kibana.conf

EXPOSE 5601

CMD [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf" ]

