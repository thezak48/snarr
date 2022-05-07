FROM cr.repo.sm-dev.uk/base:alpine

EXPOSE 8989

RUN apk add --no-cache sqlite-libs && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main tinyxml2 && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community libmediainfo && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing mono

ARG VERSION
ARG SBRANCH
ARG PACKAGE_VERSION=${VERSION}
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://download.sonarr.tv/v3/${SBRANCH}/${VERSION}/Sonarr.${SBRANCH}.${VERSION}.linux.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[thezak48]\nUpdateMethod=Docker\nBranch=${SBRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
