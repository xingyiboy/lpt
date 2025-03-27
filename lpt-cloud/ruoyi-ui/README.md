<!--
 * @Date: 2025-03-28 00:08:28
 * @LastEditors: xingyi && 2416820386@qq.com
 * @LastEditTime: 2025-03-28 00:21:54
 * @FilePath: \ruoyi-ui\README.md
-->

## 开发

```bash
# 克隆项目
git clone https://gitee.com/y_project/RuoYi-Vue

# 进入项目目录
cd ruoyi-ui

# 安装依赖
npm install

# 建议不要直接使用 cnpm 安装依赖，会有各种诡异的 bug。可以通过如下操作解决 npm 下载速度慢的问题
npm install --registry=https://registry.npmmirror.com

# 启动服务
npm run dev
```

浏览器访问 http://113.45.31.128:80

## 发布

```bash
# 构建测试环境
npm run build:stage

# 构建生产环境
npm run build:prod
```
