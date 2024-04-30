## 베이스 이미지
#FROM node:20.12.2
#
## 클라우드 환경에서의 디렉토리를 의미
#WORKDIR /front-vue
#
## package.json 워킹 디렉토리에 복사 (.은 설정한 워킹 디렉토리를 뜻함)
#COPY package.json .
#
## 현재 디렉토리에 있는 모든 파일을 WORKDIR로 이동
#COPY . .
#
## RUN 명령어는 쉘 명령어를 실행하고 결과를 새로운 레이어로 커밋
## 필요한 의존관계 라이브러리를 설치
#RUN npm install
#RUN npm i axios
#RUN npm i lodash
#RUN npm install vuex@next --save
#
## 포트번호 노출
#EXPOSE 8080
#
## 컨테이너가 시작되었을 때 실행할 명령어
## 스크립트 실행 명령어
#CMD ["npm", "run", "serve"]


# git-action version
# build
FROM node:20.12.2 AS build
WORKDIR /frontapp
COPY . .
RUN npm install
RUN npm run build

# production
FROM node:20.12.2-alpine AS production
WORKDIR /frontapp
COPY --from=build /frontapp .
CMD ["npm", "run", "serve"]
