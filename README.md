# LPT Cloud 微服务项目

<div align="center">
<h1>LPT 项目集合</h1>
</div>

<div align="center">
一个包含多个企业级项目的集合，涵盖微服务架构、单体应用、前端项目等多种技术栈
</div>

## 📚 项目介绍

本项目集合包含多个独立项目，每个项目都针对不同的业务场景和技术需求。从微服务架构到单体应用，从前端项目到后端服务，提供了完整的企业级解决方案。

## 📋 项目结构

### 1. lpt-cloud (接口平台)

```
lpt-cloud/
├── react-ui/              // React前端项目
├── ruoyi-gateway/         // 网关服务
├── ruoyi-auth/           // 认证中心
├── ruoyi-api/            // 接口模块
├── ruoyi-common/         // 通用模块
├── ruoyi-modules/        // 业务模块
├── ruoyi-visual/         // 图形化管理模块
├── sql/                  // 数据库脚本
└── docker/               // docker配置
```

### 2. lpt-clound-item (在线体验)

```
lpt-clound-item/
```

### 3. lpt-maven (Maven 项目)

```
lpt-maven/
```

### 4. lpt-single-item (单体部署应用)

```
lpt-single-item/
```

### 5. react-official-website (React 官网)

```
react-official-website/
```

## 🔨 技术栈

### 后端技术栈

- Spring Cloud Alibaba
- Spring Boot
- Spring Security OAuth2
- MyBatis Plus
- Redis
- MySQL
- Nacos
- Gateway
- Sentinel
- Seata

### 前端技术栈

- Vue 3 / React
- TypeScript
- Vite
- Pinia / Redux
- Element Plus / Ant Design
- Axios

## 🚀 快速开始

### 环境要求

- JDK 1.8+
- Maven 3.6+
- MySQL 5.7+
- Redis 6.0+
- Node.js 14+

### 项目启动说明

#### 后端微服务项目

```bash
# 克隆项目
git clone https://gitee.com/xingyiboy/lpt.git

# 进入某个项目目录
cd lpt-cloud

# 安装依赖
mvn clean install

# 启动服务
# 按顺序启动：Nacos -> Gateway -> Auth -> 其他服务
```

#### 前端项目

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev / npm start

# 构建生产环境
npm run build
```

## 🔧 配置说明

主要配置文件位于各个模块的 `resources` 目录下：

- `application.yml`: 应用基础配置
- `bootstrap.yml`: 服务注册配置
- `application-dev.yml`: 开发环境配置
- `application-prod.yml`: 生产环境配置

## 🌟 主要功能

## 🤝 贡献指南

## 📄 开源协议

## 👥 维护者

- [@xingyi](https://gitee.com/xingyiboy)

## 🙏 鸣谢

感谢所有为这个项目做出贡献的开发者！
