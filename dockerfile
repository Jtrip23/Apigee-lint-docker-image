ARG BASE_REGISTRY=fmk.nexus.onefiserv.net
ARG BASE_IMAGE=fmk/node/node18
ARG BASE_TAG=FMK-10-25-23
ARG FMK_BASE_IMAGE=${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

FROM ${FMK_BASE_IMAGE}

USER root

WORKDIR /home/node

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install all dependencies
RUN npm install

# Copy remaining application code
COPY . .

# Install apigeelint globally if needed
RUN npm install apigeelint -g

# Install apigeelint as dev dependency (optional, if used in your build/test only)
RUN npm install apigeelint --save-dev

# Copy your plugin directories as before
COPY ftsPlugin/ /home/node/apigeelint/ftsPlugin/

# If apigeelint requires plugin npm install
WORKDIR /home/node/apigeelint
RUN npm install

# Return to workdir
WORKDIR /home/node

ENV NODE_PATH="${PATH}:/home/node/apigeelint/node_modules:/home/lint_module"

CMD ["echo FISERV APIM Apigeelint image"]