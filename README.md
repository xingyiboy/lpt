# 令牌通 LPT 项目

<div align="center">
<h1>LPT 项目集合</h1>
</div>
<div align="center">
企业级登录中台项目-令牌通
</div>


## 📚 项目介绍

本项目集合包含多个独立项目，每个项目都针对不同的业务场景和技术需求。从微服务架构到单体应用，从前端项目到后端服务，提供了完整的企业级多因子登录验证解决方案。包含字符校验，数字计算校验， 邮箱校验，行为校验，人脸校验。可以通过请求接入到接口平台实现高效的校验切换，登录计算风险因子，通过因子的比例判断高风险，中风险，低风险，提供不同的验证方式，为企业进行管理自己的账户提供优秀的方案，是一个企业登录中台系统。

实现了多个项目下账户的IP，登录设备，地理位置经纬度，登录时间，历史登录信息等等信息的观察
以进行风险因子计算，并判断对应验证流程体系方式：
字符校验，数字计算校验，滑动校验，旋转校验，滑动还原校验，文字点选校验，邮箱校验，人脸校验等等（可扩展）

官网教程：http://113.45.31.128:9999/home
登录中台：http://113.45.31.128:99
项目体验：https://113.45.31.128

## 📋 项目结构

本项目包含五个主要子项目，每个都针对不同的应用场景：
注意以下的mysql和redis和necos等均被初始化，请自行设置后再运行

### 1. lpt-cloud (接口平台-（企业登录中台）)

基于微服务架构的接口管理平台，采用 Spring Cloud Alibaba + React 技术栈。

```
lpt-cloud/
├── react-ui/              // React前端项目，基于Ant Design构建的管理界面
├── ruoyi-gateway/         // 网关服务，统一接口访问入口
├── ruoyi-auth/           // 认证中心，处理用户登录和权限认证
├── ruoyi-api/            // 接口模块，提供对外服务接口
├── ruoyi-common/         // 通用模块，包含公共工具和组件
├── ruoyi-modules/        // 业务模块，包含各个微服务
├── ruoyi-visual/         // 图形化管理模块，提供监控和可视化功能
├── sql/                  // 数据库脚本，包含表结构和基础数据
└── docker/               // docker配置，用于容器化部署
```

### 2. lpt-clound-item (在线体验-（单项目-使用http接口连接登录中台示例）)

提供在线体验功能的云平台项目，采用分布式架构。

```
lpt-clound-item/
├── react-ui/              // 前端展示界面
├── ruoyi-admin/          // 后台管理服务
├── ruoyi-common/         // 公共模块
├── ruoyi-framework/      // 框架核心
├── ruoyi-generator/      // 代码生成服务
├── ruoyi-quartz/         // 定时任务调度
└── ruoyi-system/         // 系统管理模块
```

### 3. lpt-maven (Maven 项目-（提供依赖包-使单项目快速集成登录中台）)

基础工具集成项目，提供常用功能组件。

```
lpt-maven/
├── src/
│   └── main/
│       └── java/
│           └── lpt/
│               ├── application/    // 行为验证应用核心
│               ├── cache/         // 缓存处理
│               ├── common/        // 通用工具类
│               ├── faceDTO/       // 人脸识别数据对象
│               ├── generator/     // 代码生成
│               ├── interceptor/   // 拦截器
│               ├── resource/      // 资源文件
│               └── validator/     // 数据验证
│               └── LptCharacterUtil     // 字符验证工具类
│               └── LptDigitalCountUtil     // 数字计算验证工具类
│               └── LptFaceComparisonUtil     // 人脸验证工具类
│               └── LptIpVerification/     // IP验证工具类
│               └── LptMailboxUtil     // 邮箱验证工具类
└── pom.xml                       // Maven配置文件
```

### 4. lpt-single-item (单体部署应用-（单项目-使用maven依赖包集成登录中台示例）)

单体架构版本，适合中小型项目快速部署。

```
lpt-single-item/
├── react-ui/              // 前端界面
├── ruoyi-admin/          // 后台管理
├── ruoyi-common/         // 通用模块
├── ruoyi-framework/      // 框架核心
├── ruoyi-generator/      // 代码生成
├── ruoyi-quartz/         // 定时任务
└── ruoyi-system/         // 系统功能
```

### 5. react-official-website (令牌通LPT官网)

项目官方网站，基于 React + TypeScript 开发。

```
react-official-website/
├── public/                // 静态资源目录
│   └── index.html        // 主 HTML 文件
├── src/                  // 源代码目录
│   ├── assets/          // 资源文件目录
│   │   ├── css/        // 样式文件
│   │   ├── data/       // JSON 数据文件
│   │   │   ├── docs.json //教程数据
│   │   │   ├── filter_data.json //筛选数据
│   │   │   ├── footer.json //底部数据
│   │   │   └── search_titles.json //顶部导航数据
│   │   ├── img/        // 图片资源
│   │   ├── svg/        // SVG 图标
│   │   └── theme/      // 主题相关
│   ├── base-ui/        // 基础 UI 组件
│   ├── components/     // 业务组件
│   ├── hooks/         // React Hooks
│   ├── router/        // 路由配置
│   ├── services/      // 接口服务
│   ├── store/         // 状态管理
│   ├── utils/         // 工具函数
│   ├── views/         // 页面视图
│   │   ├── docs/      // 文档页面
│   │   └── home/      // 首页
│   ├── App.tsx        // 应用入口组件
│   └── index.tsx      // 应用入口文件
├── .browserslistrc     // 浏览器兼容配置
├── .editorconfig       // 编辑器配置
├── .env.development    // 开发环境配置
├── .env.production     // 生产环境配置
├── react-app-env.d.ts  // React 环境声明文件
└── package.json        // 项目依赖配置
```

每个子项目都可以独立部署运行，也可以根据需求组合使用。微服务版本适合大型企业应用，单体版本则更适合中小型项目快速落地。

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
- Element Plus
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
# ruoyi-admin/
```

#### 后端单体项目

```bash
# 克隆项目
git clone https://gitee.com/xingyiboy/lpt.git

# 进入某个项目目录
cd lpt-cloud-item

# 安装依赖
mvn clean install

# 启动服务
# ruoyi-admin -> src -> java->RuoYiApplication.java
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

![image-20250413110411601](README.assets/image-20250413110411601.png![image-20250821154932463](README.assets/image-20250821154932463.png)

![image-20250413110434128](README.assets/image-20250413110434128.png![image-20250821155005518](README.assets/image-20250821155005518.png)

![image-20250821155039668](README.assets/image-20250821155039668.png)

<img src="README.assets/image-20250413110520772.png" alt="image-20250413110520772" style="zoom:33%;" />

<img src="README.assets/image-20250413110557099.png" alt="image-20250413110557099" style="zoom:33%;" />

<img src="README.assets/image-20250413110650472.png" alt="image-20250413110650472" style="zoom:33%;" />

<img src="README.assets/image-20250413110713407.png" alt="image-20250413110713407" style="zoom:33%;" />

<img src="README.assets/image-20250413110729931.png" alt="image-20250413110729931" style="zoom:33%;" />

<img src="README.assets/image-20250413110754387.png" alt="image-20250413110754387" style="zoom:33%;" />

<img src="README.assets/image-20250413110941316.png" alt="image-20250413110941316" style="zoom:33%;" />

<img src="README.assets/image-20250413111042076.png" alt="image-20250413111042076" style="zoom:33%;" />

![image-20250821155117939](README.assets/image-20250821155117939.png)

![image-20250413111116212](README.assets/image-20250413111116212.png)

![image-20250413111138677](README.assets/image-20250413111138677.png)

![image-20250413111202166](README.assets/image-20250413111202166.png)



## 👥 维护者

- [@xingyi](https://gitee.com/xingyiboy)

## 🙏 鸣谢

感谢所有为这个项目做出贡献的开发者！
