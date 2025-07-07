ARG BASE_REGISTRY=fmk.nexus.onefiserv.net

ARG BASE_IMAGE=fmk/node/node18

ARG BASE_TAG=FMK-10-25-23

ARG FMK_BASE_IMAGE=${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

FROM ${FMK_BASE_IMAGE}

USER root

WORKDIR /home/node

RUN cat .npmrc

CMD ["node"]

RUN npm install apigeelint -g

RUN npm install apigeelint --save-dev

#COPY externalPlugins/ /home/node/apigeelint/node_modules/externalPlugins/

COPY ftsPlugin/ /home/node/apigeelint/ftsPlugin/

RUN cd apigeelint

RUN npm i

#RUN ln -s ftsPlugin /usr/local/lib/node_modules/apigeelint/node_modules/

#RUN ln -s externalPlugins /usr/local/lib/node_modules/apigeelint/node_modules/

WORKDIR /home/node

#RUN chown node:node /home/node/externalPlugins/ && chown node:node /home/node/ftsPlugin/

ENV NODE_PATH="${PATH}:/home/node/apigeelint/node_modules:/home/lint_module"

CMD ["echo FISERV APIM Apigeelint image"]

#FROM maninorg/apigeelint:latest

