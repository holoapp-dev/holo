FROM node:22 AS builder
WORKDIR /app

COPY package.json ./
COPY yarn.lock ./
COPY prisma ./

RUN yarn install --production

COPY . .

RUN npx prisma generate
RUN yarn build
RUN yarn autoclean --force



FROM node:22-alpine

WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/tsconfig.json ./tsconfig.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/yarn.lock ./
COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD [ "yarn", "run", "start:prod" ]
