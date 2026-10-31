# steam-headless-zh

给 [josh5/steam-headless](https://steamheadless.com/docs/) 补上简体中文与 fcitx5 拼音的镜像。

上游 `josh5/steam-headless:2` 把 KDE/Plasma 的翻译词库裁掉了（`/usr/share/locale/zh_CN/LC_MESSAGES` 只剩 33 个无关文件），
桌面永远是英文，而且 `dnf reinstall` 也补不回来（镜像内已装版本已从 Fedora 仓库消失）。

本镜像做三件事：

1. 预置 423 个 zh_CN `.mo` 与 26 个 KF6 `.qm`（取自 Fedora 44 的 plasma-*、kf6-*、kde 应用包）
2. 装 Noto CJK 字体与 fcitx5 拼音输入法
3. 把 `/etc/locale.conf`、`/etc/xdg/plasma-localerc`、fcitx5 自启动写成中文默认

## 构建

推送到 `main` 分支后 GitHub Actions 自动构建并 push 到 Docker Hub：

- `$DOCKERHUB_USERNAME/steam-headless-zh:latest`
- `$DOCKERHUB_USERNAME/steam-headless-zh:<run_number>`

需要两个仓库 secret：`DOCKERHUB_USERNAME`、`DOCKERHUB_TOKEN`（Docker Hub 的 Read/Write token）。

## 使用

在 NAS 上把 compose 的 image 指向本镜像即可，不需要本机构建：

```yaml
services:
  steam-headless:
    image: <你的dockerhub用户名>/steam-headless-zh:latest
```

完整示例见 `docker-compose.override.example.yml`，需要和上游 2.x 的 compose 叠加使用：

```bash
docker compose -f docker-compose.yml -f docker-compose.override.yml pull
docker compose -f docker-compose.yml -f docker-compose.override.yml up -d
```

升级上游后重新拉取即可：`docker compose pull && docker compose up -d`。
