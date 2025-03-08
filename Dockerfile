FROM node:18-alpine as builder

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY tailwind.config.ts postcss.config.js ./

COPY . .

RUN npm run build

FROM node:18-alpine as runner


WORKDIR /app

COPY --from=builder /app/package.json /app/package-lock.json ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/tailwind.config.ts ./tailwind.config.ts
COPY --from=builder /app/postcss.config.js ./postcss.config.js

ENV NODE_ENV=production

EXPOSE 3000

CMD ["npm", "run", "start"]
