FROM aquasec/trivy as downloader
RUN trivy image --download-db-only \
    && trivy image --download-java-db-only \
    && cd /root/.cache/trivy \
    && tar -czvf /tmp/trivy-db.tar.gz db \
    && tar -czvf /tmp/trivy-java-db.tar.gz java-db

FROM busybox
COPY --from=downloader /tmp/*.tar.gz /data/