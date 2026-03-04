### Build this locally with 

```sh
# Solr 8.4
podman build \
  --build-arg SOLR_VERSION=8.4.0 \
  -t pulibrary/ci-solr:8.4-v2.0.0 \
  .

# Solr 9.9
podman build \
  --build-arg SOLR_VERSION=9.9.0 \
  -t pulibrary/ci-solr:9.9-v1.0.0 \
  .
```

Login to your github account with

```bash
echo YOUR_GITHUB_TOKEN | podman login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin
```

You can build and push your changes with (multi-arch recommended)


```bash
# Solr 8.4 multi-arch manifest
podman manifest create ghcr.io/pulibrary/ci-solr:8.4-v2.0.0
podman build --platform linux/amd64 --build-arg SOLR_VERSION=8.4.0 --manifest ghcr.io/pulibrary/ci-solr:8.4-v2.0.0 .
podman build --platform linux/arm64 --build-arg SOLR_VERSION=8.4.0 --manifest ghcr.io/pulibrary/ci-solr:8.4-v2.0.0 .
podman manifest push --all ghcr.io/pulibrary/ci-solr:8.4-v2.0.0 docker://ghcr.io/pulibrary/ci-solr:8.4-v2.0.0

# Solr 9.9 multi-arch manifest
podman manifest create ghcr.io/pulibrary/ci-solr:9.9-v1.0.0
podman build --platform linux/amd64 --build-arg SOLR_VERSION=9.9.0 --manifest ghcr.io/pulibrary/ci-solr:9.9-v1.0.0 .
podman build --platform linux/arm64 --build-arg SOLR_VERSION=9.9.0 --manifest ghcr.io/pulibrary/ci-solr:9.9-v1.0.0 .
podman manifest push --all ghcr.io/pulibrary/ci-solr:9.9-v1.0.0 docker://ghcr.io/pulibrary/ci-solr:9.9-v1.0.0
```
```
