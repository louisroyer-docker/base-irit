# Copyright 2024 Louis Royer. All rights reserved.
# Use of this source code is governed by a MIT-style license that can be
# found in the LICENSE file.
# SPDX-License-Identifier: MIT

FROM debian:bookworm-slim

LABEL maintainer="Louis Royer <louis.royer@irit.fr>" \
      org.opencontainers.image.authors="Louis Royer <louis.royer@irit.fr>" \
      org.opencontainers.image.source="https://github.com/louisroyer-docker/base-irit"

# Used to disable caching of next steps, if not build since 1 day,
# allowing to search and apply security upgrades
ARG BUILD_DATE=""

RUN apt-get update -q && \
    DEBIAN_FRONTEND=non-interactive apt-get upgrade -qy && \
    DEBIAN_FRONTEND=non-interactive apt-get install -qy ca-certificates --no-install-recommends --no-install-suggests && \
    mkdir -p /etc/apt/sources.list.d && \
    echo "deb https://deb-royer.irit.fr/debian bookworm/" > /etc/apt/sources.list.d/deb-royer.irit.fr.list && \
    apt-get -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradetoInsecureRepository=true update -q && \
    DEBIAN_FRONTEND=non-interactive apt-get -o APT::Get::AllowUnauthenticated=true install -qy deb-irit-archive-keyring --no-install-recommends --no-install-suggests && \
    rm -rf /var/lib/apt/lists/*
