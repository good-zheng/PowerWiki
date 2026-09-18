# PowerWiki Dockerfile
# 单阶段精简构建：Node 环境 -> npm install -> 直接启动（项目无编译步骤）

FROM node:22-alpine

# 设置工作目录
WORKDIR /app

# 安装 git（必需）：Wiki 内容依赖克隆/同步远程仓库，simple-git 与 git clone 均调用 git 二进制
# 构建机位于腾讯云：将 Alpine 默认 CDN 替换为腾讯内网镜像源，避免 apk 下载缓慢（默认源实测约 8-9 分钟）
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tencentyun.com/g' /etc/apk/repositories \
    && apk add --no-cache git

# 复制依赖清单并安装生产依赖（跳过 devDependencies，如 nodemon）
COPY package*.json ./
RUN npm install --omit=dev && npm cache clean --force

# 复制应用代码
COPY . .

# 创建数据与缓存目录（与 docker-compose 的卷挂载点保持一致）
RUN mkdir -p /app/data /app/cache

# 设置环境变量
ENV NODE_ENV=production \
    DATA_DIR=/app/data \
    GIT_CACHE_DIR=/app/cache \
    CONFIG_PATH=/app/config.json

# 暴露端口（实际监听端口优先级：环境变量 PORT > config.json 的 port 字段 > 默认 3150）
EXPOSE 80

# 启动应用
CMD ["npm", "start"]
