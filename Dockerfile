# syntax=docker/dockerfile:1

ARG NODE_VERSION=20.15.0
FROM node:${NODE_VERSION}-alpine

# Use production node environment by default.
ENV NODE_ENV production

# Set the working directory.
WORKDIR /usr/src/app

# Copy package files first to leverage Docker caching.
COPY package.json package-lock.json ./

# Install dependencies using npm ci for reproducible builds.
RUN npm ci --omit=dev

# Copy the rest of the application files.
COPY . .

# Run the application as a non-root user.
USER node

# Expose the port that the application listens on.
EXPOSE 3000

# Run the application.
CMD ["npm", "start"]
