FROM node:22 AS builder
WORKDIR /app

COPY package.json ./
COPY yarn.lock ./
COPY prisma ./

RUN yarn install --frozen-lockfile

COPY . .

RUN npx prisma generate
RUN yarn build

FROM node:22

WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/yarn.lock ./
COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD [ "yarn", "run", "start:prod" ]
