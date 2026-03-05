ARG SOLR_VERSION
FROM docker.io/library/solr:${SOLR_VERSION}

# Avoid relying on SOLR_USER env existing at build time
ARG SOLR_USER=solr

# Copy scripts/configs
COPY --chown=${SOLR_USER}:${SOLR_USER} security.json /opt/solr/security.json
COPY --chown=${SOLR_USER}:${SOLR_USER} ci-start.sh /opt/solr/server/scripts/ci-start.sh
COPY --chown=${SOLR_USER}:${SOLR_USER} lando-start.sh /opt/solr/server/scripts/lando-start.sh

ENV BASE_URL=https://raw.githubusercontent.com/pulibrary/princeton_ansible/main/roles/solrcloud/files \
    JTS_URL=${BASE_URL}/jts-core-1.15.1.jar \
    CJK_URL=${BASE_URL}/CJKFoldingFilter.jar \
    UMICH_URL=${BASE_URL}/lucene-umich-solr-filters-6.0.0-SNAPSHOT.jar \
    EXTRAS_BASE_PATH=/opt/solr/contrib/analysis-extras/lib \
    CJK_PATH=${EXTRAS_BASE_PATH}/CJKFoldingFilter.jar \
    UMICH_PATH=${EXTRAS_BASE_PATH}/lucene-umich-solr-filters-6.0.0-SNAPSHOT.jar \
    WEBAPP_BASE_PATH=/opt/solr/server/solr-webapp/webapp/WEB-INF/lib \
    JTS_PATH=${WEBAPP_BASE_PATH}/jts-core-1.15.1.jar

USER root

RUN set -eux; \
    mkdir -p "${EXTRAS_BASE_PATH}" "${WEBAPP_BASE_PATH}"; \
    wget -q -t 5 -T 30 "${CJK_URL}"   -O "${CJK_PATH}"; \
    wget -q -t 5 -T 30 "${UMICH_URL}" -O "${UMICH_PATH}"; \
    wget -q -t 5 -T 30 "${JTS_URL}"   -O "${JTS_PATH}"; \
    chown -R "${SOLR_USER}:${SOLR_USER}" /opt/solr

USER ${SOLR_USER}
