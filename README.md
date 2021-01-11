# 更新说明

原作者长时间未进行更新，因此用perl进行了简单修改。

添加了一个config.exe用于更新赛制及排版。

使用方法：在config.js中编辑赛制后，双击config.exe。

ps：填写赛制请注意格式。

原作者MrAMS，详见https://github.com/MrAMS/Timer

# 原始文档

成都七中嘉祥外国语学校 2019年第十二届 “海天杯”辩论赛 **倒计时器**

![](https://mrams.gitee.io/img/Project/jx-haitianbei/img.PNG)


![](https://mrams.gitee.io/img/Project/jx-haitianbei/img2.PNG)

支持倒计时与**交替计时**功能。当时间剩余30秒或结束时，自动鸣笛示意。

离线版本，下载后直接使用最新版本Chrome或FireFox打开即可，无需联网。

## 使用说明

#### 软件操作

单击比赛环节开始倒计时，中途可单击暂停暂停倒计时。

#### 配置比赛信息

找到根目录下的`config.js`，打开并编辑配置信息即可：
```js
// 配置计时器信息
// 字符串请用""包住
// 
// 辩题
var name_topic = "辩题"
// 正方
var name_aff = "高2018级3班"
// 反方
var name_neg = "高2017级1班"
```
**注意：** 更多信息（如学校名称、logo、比赛名称、比赛环节）需要在源代码中修改，~~暂时咕咕~~，可以联系作者我定制

## 开发

下一步考虑使用`vue.js`重构，~~咕咕~~

使用jQuery + Bootstarp4开发，欢迎交流
