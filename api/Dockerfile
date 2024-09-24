FROM node:22 AS builder
# Create app directory
WORKDIR /app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package.json ./
COPY yarn.lock ./
COPY prisma ./

# Install app dependencies
RUN yarn install

COPY . .

RUN npx prisma generate
RUN yarn build

FROM node:22

WORKDIR /app

COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/tsconfig.json ./tsconfig.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/yarn.lock ./
COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD [ "yarn", "run", "start:prod" ]
