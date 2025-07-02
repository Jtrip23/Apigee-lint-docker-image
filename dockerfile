ARG BASE_REGISTRY=fmk.nexus.onefiserv.net
ARG BASE_IMAGE=fmk/node/node18
ARG BASE_TAG=FMK-10-25-23
ARG FMK_BASE_IMAGE=${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

FROM ${FMK_BASE_IMAGE}

USER root

WORKDIR /home/node

# Install apigeelint globally
RUN npm install -g apigeelint

# Copy ftsPlugin if needed by apigeelint CLI usage
COPY ftsPlugin/ /home/node/ftsPlugin/

# Set environment variable if required by your plugin
ENV NODE_PATH="${PATH}:/home/node/ftsPlugin"

# Set entrypoint to apigeelint so it runs by default
ENTRYPOINT ["apigeelint"]

# Provide default arguments or override in pipeline script
CMD ["--version"]