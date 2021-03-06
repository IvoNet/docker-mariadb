FROM mariadb:10.7.3
LABEL maintainer="Ivo Woltring <@ivonet>"

ENV TEST_DIR=/testdata

COPY setup/testdata-watcher.sh /usr/local/bin/
COPY setup/ivonet-entrypoint.sh /usr/local/bin/
COPY setup/docker.cnf /etc/mysql/conf.d/docker.cnf
RUN ln -s /usr/local/bin/ivonet-entrypoint.sh /ivonet-entrypoint.sh \
    && ln -s /usr/local/bin/testdata-watcher.sh /testdata-watcher.sh \
    && chmod +x /ivonet-entrypoint.sh /testdata-watcher.sh \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
    inotify-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


VOLUME ["$TEST_DIR"]
ENTRYPOINT ["ivonet-entrypoint.sh"]
CMD ["mariadbd"]
