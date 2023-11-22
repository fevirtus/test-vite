FROM nginx:1.16.0-alpine

WORKDIR /app

COPY . .

RUN npm install -g yarn

RUN yarn install

RUN yarn run build

COPY --from=builder /app/dist /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY deploy/nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]