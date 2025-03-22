FROM node:18-alpine as builder

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY tailwind.config.js postcss.config.js ./

COPY . .

ENV AUTH0_BASE_URL="http://localhost"
ENV AUTH0_SECRET="dummy_secret"
ENV AUTH0_ISSUER_BASE_URL="https://dummy.auth0.com"
ENV AUTH0_CLIENT_ID="dummy_client_id"
ENV AUTH0_CLIENT_SECRET="dummy_client_secret"
ENV OPENAI_API_KEY="dummy_openai_key"
ENV STRIPE_SECRET_KEY="dummy_stripe_secret_key"
ENV STRIPE_PRODUCT_PRICE_ID="dummy_price_id"
ENV STRIPE_WEBHOOK_SECRET="dummy_webhook_secret"
ENV MONGODB_URI="mongodb://localhost:27017/dummy"


RUN npm run build

FROM node:18-alpine as runner


WORKDIR /app


COPY --from=builder /app/package.json /app/package-lock.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/tailwind.config.js ./tailwind.config.js
COPY --from=builder /app/postcss.config.js ./postcss.config.js

ENV NODE_ENV=production

EXPOSE 3000

CMD ["npm", "run", "start"]
