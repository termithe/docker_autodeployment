FROM node:latest as build-stage
WORKDIR /
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

FROM nginx as production-stage
RUN mkdir /app
COPY --from=build-stage /dist /app
COPY nginx.conf /etc/nginx/nginx.conf