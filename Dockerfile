FROM node:lts-alpine as builder

WORKDIR /app

COPY package.json .
COPY yarn.lock .
RUN yarn

COPY . .
RUN yarn build

# we care about /app/build <-- to serve by nginx

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html