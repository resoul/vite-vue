FROM node:20-alpine AS build-stage

# set working directory
WORKDIR /app

# copy package.json and package-lock.json to workdir
COPY package*.json ./

# install app dependencies or npm ci
RUN npm install --no-audit --silent

# copy everyting (sourcecode) to docker env (workdir)
COPY . ./

# build production
RUN npm run build

#Stage 2
FROM nginx:1.25.0-alpine AS production-stage

WORKDIR /usr/share/nginx/html

#remove all default files nginx 
RUN rm -rf ./*

#copy nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

#copy all files and folder (dist) to workdir
COPY --from=build-stage /app/dist ./

ENTRYPOINT ["nginx", "-g", "daemon off;"]
