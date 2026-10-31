# Steam Headless 中文镜像（简体中文桌面 + fcitx5 拼音）
#
# 上游镜像 josh5/steam-headless:2 把 KDE/Plasma 的翻译词库裁掉了，
# 只剩 33 个无关的 .mo，所以界面永远是英文。这里做两件事：
#   1) 把 423 个 zh_CN .mo / 26 个 KF6 .qm 直接补进 /usr/share/locale
#   2) 补中文字体与 fcitx5 输入法，并把 /etc/locale.conf 改成 zh_CN
#
# 词库来源：Fedora 44 官方仓库里的 plasma-* / kf6-* / kde 应用包，见 zh-locale/。
FROM josh5/steam-headless:2

# 中文字体 + fcitx5 拼音（仅此一步需要联网）
RUN dnf install -y --skip-broken --setopt=install_weak_deps=False \
      glibc-langpack-zh \
      google-noto-sans-cjk-ttc-fonts google-noto-serif-cjk-ttc-fonts \
      fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx5-gtk fcitx5-qt \
 && dnf clean all \
 && rm -rf /var/cache/dnf

# 预置中文翻译与系统级默认配置
COPY zh-locale/ /
COPY files/ /

RUN set -eux; \
    n=$(find /usr/share/locale/zh_CN/LC_MESSAGES -name '*.mo' | wc -l); \
    echo "zh_CN .mo 词库数量: $n"; \
    test "$n" -gt 300; \
    test -f /usr/share/locale/zh_CN/LC_MESSAGES/plasmashell.mo; \
    test -f /usr/share/locale/zh_CN/LC_MESSAGES/kcm_lookandfeel.mo; \
    test -f /usr/share/locale/zh_CN/LC_MESSAGES/dolphin.mo

# KDE 桌面会话从 /etc/locale.conf 取 locale，不改这里 plasma 会退回 C.UTF-8
RUN printf 'LANG=zh_CN.UTF-8\nLANGUAGE=zh_CN\n' > /etc/locale.conf

ENV LANG=zh_CN.UTF-8
