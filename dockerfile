ARG BASE_REGISTRY=fmk.nexus.onefiserv.net
ARG BASE_IMAGE=fmk/node/node18
ARG BASE_TAG=FMK-10-25-23
ARG FMK_BASE_IMAGE=${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

FROM ${FMK_BASE_IMAGE}

USER root

WORKDIR /home/node

# (Optional) Review if .npmrc exists in build context. Else, remove this line.
# RUN cat .npmrc

# Install apigeelint globally
RUN npm install -g apigeelint

# Copy ftsPlugin if needed by apigeelint CLI usage
COPY ftsPlugin/ /home/node/ftsPlugin/

# Set environment variable if required
ENV NODE_PATH="${PATH}:/home/node/ftsPlugin"

# Default entrypoint to apigeelint
ENTRYPOINT ["apigeelint"]

# Optional: provide default arguments or override in CI script
CMD ["--version"]