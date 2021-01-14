# Builder stage 
# FROM부터 다음 FROM까지는 모두 Builder stage라는것을 명시
# 빌드 파일을 생성하는 것이 목표. 
# 생성된 파일과 폴더들은 /usr/src/app/build로 들어감
FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./
RUN npm run build

ENV CHOKIDAR_USEPOLLING=true

 # Run stage
FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
 