<div align="center">

# 🎮 steam-headless-zh

> 给 josh5/steam-headless 补上简体中文与 fcitx5 拼音的镜像

[![Docker Image](https://img.shields.io/badge/Docker-steam--headless--zh-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/melanrabbit/steam-headless-zh)
[![Build](https://img.shields.io/badge/Build-GitHub%20Actions-green?style=for-the-badge&logo=githubactions)](https://github.com/Melanrabbit/steam-headless-zh/actions)

中文桌面 · KDE 词库 · 中文字体 · fcitx5 拼音

</div>

---

## 📑 目录

- [✨ 功能概览](#-功能概览)
- [🚀 使用](#-使用)
- [⚙️ 配置](#️-配置)
- [🔁 更新](#-更新)
- [📄 说明](#-说明)

---

## ✨ 功能概览

✅ **中文词库补全**：预置 423 个 zh_CN `.mo` 与 26 个 KF6 `.qm`，取自 Fedora 44 的 plasma、kf6 与 KDE 应用包

✅ **中文字体**：安装 Noto Sans CJK 与 Noto Serif CJK，界面与网页不再豆腐块

✅ **拼音输入法**：安装 fcitx5 与中文附加组件，挂到桌面会话的 systemd target 上随机启动

✅ **中文默认环境**：`/etc/locale.conf`、`/etc/xdg/plasma-localerc` 与输入法自启动统一改为中文

✅ **构建期自检**：校验词库数量、关键 `.mo` 与 fcitx5 unit 是否齐全，缺一项就失败

---

## 🚀 使用

在 NAS 上把 compose 的 image 指向本镜像即可，不需要本机构建：

```yaml
services:
  steam-headless:
    image: melanrabbit/steam-headless-zh:latest
```

完整示例见 `docker-compose.override.example.yml`，需要和上游 2.x 的 compose 叠加使用：

```bash
docker compose -f docker-compose.yml -f docker-compose.override.yml pull
docker compose -f docker-compose.yml -f docker-compose.override.yml up -d
```

---

## ⚙️ 配置

| 变量 | 说明 |
|:-----|:-----|
| `LANG` | 已内置 `zh_CN.UTF-8`，无需额外设置 |
| `DOCKERHUB_USERNAME` | 构建用 secret，Docker Hub 用户名 |
| `DOCKERHUB_TOKEN` | 构建用 secret，Docker Hub Read/Write token |

镜像标签：

| 标签 | 说明 |
|:-----|:-----|
| `latest` | 最近一次构建 |
| `<run_number>` | 对应 Actions 运行序号，可用于回滚 |

---

## 🔁 更新

- 推送到 `main` 自动构建并推送，只改 `*.md` 或 `docs/` 不会触发构建
- 上游 2.x 更新后重新拉取即可：`docker compose pull && docker compose up -d`

---

## 📄 说明

- 本仓库只维护本地化层，桌面与 Steam 运行时来自上游 `josh5/steam-headless`，遵循其原始许可。
- 上游裁掉了 KDE 翻译词库且 `dnf reinstall` 补不回来（Fedora 仓库里对应版本已消失），所以词库直接随镜像预置。
