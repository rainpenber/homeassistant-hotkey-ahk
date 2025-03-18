# homeassistant-hotkey-ahk
autohotkey script to add hotkeys to control homeassistant entities
autohotkey脚本 通过自定义键盘快捷键控制自己的HomeAssistant设备
# 中文
本项目由cursor AI编程和本人调试完成，本项目的初衷是在电脑面前通过自定义键盘能控制家里的设备。
实现的原理是使用autohotkey注册系统快捷键，触发后发送HTTP请求，通过HomeAssistant 官方 RESTful API进行设备操控
## 使用
1. 访问你家的HomeAssistant，在{你的ha地址:端口号}/profile/security，长期访问令牌处 获取长期访问令牌
2. 在你的HomeAssistant中，获取想要控制的设备的`entity_id`
3. 编辑`ha_post_request.ahk`，根据你自己的情况修改`BASE_URL`和`AUTH_TOKEN`，以及想要控制的设备`entity_id`、快捷键
4. 如果你电脑上安装了Autohotkey v2版本，则下载源码后直接运行`ha_post_request.ahk`即可。
5. 如果没有安装，则直接运行编译好的`ha_post_request.exe`即可。（请确保ha_post_request.exe和ha_shortcuts.ini在同一目录下）

# English
This project is completed by Cursor AI and personally debugging. The initial intention of this project is to control home devices through a custom keyboard while sitting in front of a computer.

The implementation principle is to use AutoHotkey to register system hotkeys, which trigger HTTP requests. These requests interact with the Home Assistant's official RESTful API for device control.

## Usage
1. Visit your Home Assistant at `{your_ha_address:port}/profile/security`, and obtain a long-term access token in the Long-Term Access Tokens section.
2. Get the `entity_id` of the device you want to control in your Home Assistant.
3. Edit the `ha_post_request.ahk` file, and modify the `BASE_URL`, `AUTH_TOKEN`, and the `entity_id` of the device you want to control, along with the desired hotkey, according to your configuration.
4. If you have AutoHotkey v2 installed on your computer, you can directly run the `ha_post_request.ahk` script after downloading the source code.
5. If you don’t have AutoHotkey installed, you can directly run `ha_post_request.exe` from realease.(Make sure that `ha_post_request.exe` and `ha_shortcuts.ini` are in the same directory.)