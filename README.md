# SwitfUI_Eyepetizer
一款基于 SwitfUI 实现的精美仿开眼视频App(提供Kotlin、Flutter、React Native、小程序版本 😁 )<br /><br />
Kotlin：[Jetpack_Kotlin_Eyepetizer](https://github.com/fmtjava/Jetpack_Kotlin_Eyepetizer)<br /><br />
Compose：[Compose_Eyepetizer]([https://github.com/fmtjava/Jetpack_Kotlin_Eyepetizer](https://github.com/fmtjava/Compose_Eyepetizer))<br /><br />
Flutter版：[flutter_eyepetizer](https://github.com/fmtjava/flutter_eyepetizer)<br /><br />
ReactNative版：[ReactNative_Eyepetizer](https://github.com/fmtjava/ReactNative_Eyepetizer)<br /><br />
小程序版：[wx_eyepetizer](https://github.com/fmtjava/wx_eyepetizer)<br /><br />

**如果喜欢的话希望给个 `Star` 或 `Fork` ^_^ ，谢谢**

# 前言
由于近几年一直在做 ReactNative 跨端开发，经常需要编写跨端桥接插件，编写过程中需要通 IOS 的伙伴沟通了解对应平台相关特性，最近便入门了一下 Switf 语言以及 SwitfUI 框架，并通过这个项目把学到的相关技能记录下来，因为目前还在持续学习 IOS 相关技能，希望 Github 的小伙伴多多 Issues，留下你们的宝贵意见。当前如果觉得项目能够帮助到你们，也希望给一个 `Star` 或 `Fork` ^_^ ，谢谢**

# 项目截图
<div style="float:right">
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcQUqJZ4KbPa4QaiwmVmQ.zNvq.hSBS75lktljPLhlzqKCul.5COQETV49bx2HLC.0GSVDMhU3Pervtbh4neHMGA!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcUsfTkluZWSrI6tGeHxmIvbm9X3IWxmMB0*w*1uLQCSpn*qqaFB3QVKDLcfDqL4SeF5DvRCOS7mrhdJFyh3fHXQ!/b&bo=OARwCAAAAAABJ0Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcUsfTkluZWSrI6tGeHxmIvZJxy2yYHSwlhrW6bBph8kbDaiUNIBZ2uWd9w26J19YvSNKZjT6l0mHXfOkMDXH.IY!/b&bo=OARwCAAAAAABJ0Q!&rf=viewer_4" width="255"/>
</div>

<br/>

<div style="float:right">
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcUsfTkluZWSrI6tGeHxmIvY5JvV81Rb8XTIaa.BPS8IsdpWLsp.NDnvPVIKICwtTOm6iCthVBKQlR5fADUm3ucE!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcXCiAbUjcKu1jBPbX42kshw.m8kL6xMrqMiRdanFVBXAtWuvj08JsrarMi2Px6yFiKITv0eoxlMXt8N3La1kaXs!/b&bo=OARwCAAAAAABJ0Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcavTzlTG8kuGqMngjWykI7yAuHrPCOf*S3ldznIQtxpgkL9nLWjb2macjYTMBDHWBf9ILtlXS8Q0hyIBsX8w1u4!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>
</div>
<br/>

<div style="float:right">
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcavTzlTG8kuGqMngjWykI7wroj9DEOD*1ylue*0B.tCZ0476s4gdQHVRYVw6P6mD1PGCTldHm43bEmstGmDQ0KA!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcUsfTkluZWSrI6tGeHxmIvbGwvulrHRAj.zXkN6e21d6GvzqCfwaF4C8T5yWbVZiUlFZpS371nmk.5Xxhavf2lU!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcbYpu*7P3IG2l4cWH6GfBvmZsUfQc9M8STCSlUbnfQSdAoyJiYBARqXUoF394prNQcf.E7HAnByX95.US8xbVRk!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>
</div>
<br/>

<div style="float:right">
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcbYpu*7P3IG2l4cWH6GfBvkpS*EGeHd6FYWKdErwaUo5Odi7XqJkOlrfQpjIlrnix7GD4D5.FhNMtXzUi*siLU0!/b&bo=OARwCAAAAAABJ0Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcRRY0UmipAR0faJ.L5CYrlTT6bxXO3jGD5SyCRSsdcCTqTJnujozmB1oq8irk*3ebSII9d3UlforAM*i0zs2x5Y!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcbYpu*7P3IG2l4cWH6GfBvnJuM619oKuS*QMZRwkqOUfQBN0btgvp.9MmxzmFJBjMQDrE*5AKWBMMg9OsjkuV.Y!/b&bo=cAg4BAAAAAABF3Q!&rf=viewer_4" width="255"/>
</div>

<div style="float:right">
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcavTzlTG8kuGqMngjWykI7yQSQZmFPGxu4uKeKHit8KYjKItojTAbNS7cFM*XrY80VJc0E4iSZB096noqlTVQjg!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcavTzlTG8kuGqMngjWykI7w8JBYdkoLCF9sOLgUE.doJ*RkKfexYdhSSW68GKd4wLnPfpfyF5s54ONo755*wks4!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcRRY0UmipAR0faJ.L5CYrlTA.vc9kMQFMCatsFv1PUTYcjcFCH1ColsGIMOWlUuZs5wZ6kd2eI8RFbufUpzaZSw!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>
</div>

<div style="float:right">
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcRRY0UmipAR0faJ.L5CYrlRt8tIdUZFCj*hgF4WWGFgFbGOTNT5BGYMMpHH*xcLU1gFtPuBGRVoMTqPv3Zh1Nnc!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcQUqJZ4KbPa4QaiwmVmQ.zPuXhKjEjq9xowwfYF82TZmExo6FS0uEpbECtZ.Ab3RBpCaHeJ*denZpDdFBt2YBhM!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcbYpu*7P3IG2l4cWH6GfBvnqdVqyqZouI4PjFBugExXxW33*OnvA6U035qRyoC41zEE2Ny.ibWXg8ax57IACLYo!/b&bo=OARwCAAAAAABF3Q!&rf=viewer_4" width="255"/>&nbsp;&nbsp;&nbsp;
</div>

# 核心功能
<div>
  <img src="http://m.qpic.cn/psc?/V526iEgm3HgG9w0K6aQL2X9HJE4OnV96/45NBuzDIW489QBoVep5mcXCiAbUjcKu1jBPbX42kshw8FaB*hM5TU20jQpQjg4LV1NbXenIxDopoT11d0sR.PGeysmxV9wV95CPU3xj*weM!/b&bo=IwY4BAAAAAADJxs!&rf=viewer_4"/>
</div>
   
 # 更新日志
 ### v1.0
   * 初始化项目，完成仿开眼视频App核心功能，目前实现首页、发现、热门、分类、我的、视频详情、视频播放等功能。
# Thanks
  - [ToastUI](https://github.com/quanshousio/ToastUI) 
  - [ACarousel](https://github.com/JWAutumn/ACarousel) 
  - [WaterfallGrid](https://github.com/paololeonardi/WaterfallGrid) 
  - [SwiftUI-WebView](https://github.com/kylehickinson/SwiftUI-WebView)
 
 # 关于我
  - WX：fmtjava
  - QQ：2694746499
  - Email：2694746499@qq.com
  - Github：https://github.com/fmtjava
  
 # 声明
  项目中的 API 均来自开眼视频，纯属学习交流使用，不得用于商业用途！
