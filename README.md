# PicGuard

[![Test](https://github.com/picguard/picguard/actions/workflows/test.yml/badge.svg)](https://github.com/picguard/picguard/actions/workflows/test.yml)
[![Release](https://github.com/picguard/picguard/actions/workflows/release.yml/badge.svg)](https://github.com/picguard/picguard/actions/workflows/release.yml)

> Your pictures, your signature.

## Requirements

### iOS

1. 导入证书
```shell
security import ./<name>.cer -P <password> -A -t cert
```

2. 导入.p12私钥
```shell
security import ./<name>.p12 -P <password> -A -t cert -f pkcs12
```

3. 双击导入mobileprovision文件
4. 手动安装模拟器运行时
- 已安装列表
```shell
xcrun simctl runtime list
```

- 安装
```shell
xcrun simctl runtime add "~/iOS_17.0.1_Simulator_Runtime.dmg"
```

## Release

app打包发生变化，这样发布到蒲公英的版本号，会带有commit信息，方便排查；发布到Google play或app store的版本号和之前一个样。

以下脚本都在`Makefile`文件下，JetBrains / Android Studio可能需要安装`Makefile Language`插件。

### Flutter

>在`pubspec.yaml`文件修改`version: <new version>`

### Android

>如果发布到生产环境, 请在`android/app/build.gradle`文件修改`versionCode`

- 如果发布到测试环境, 运行
```shell
make apk
```

- 如果发布到生产环境, 运行
```shell
make appbundle
```

### iOS

>如果发布到生产环境, 请修改`build`号

- 如果发布到测试环境, 运行
```shell
make adhoc
```

- 如果发布到生产环境, 运行
```shell
make appstore
```

### macOS

>如果发布到生产环境, 请修改`build`号

- 如果发布到测试环境, 运行
```shell
make macos_adhoc
```

- 如果发布到生产环境, 运行
```shell
make macos_appstore
```

### Linux

```shell
# https://distributor.leanflutter.dev/makers/appimage/
dart run flutter_distributor:main package --platform linux --targets appimage

# https://distributor.leanflutter.dev/makers/deb/
dart run flutter_distributor:main package --platform linux --targets deb

# https://distributor.leanflutter.dev/makers/rpm/
dart run flutter_distributor:main package --platform linux --targets rpm
```

## Tests

### app links

#### Deep Links on Android

```shell
adb shell am start -a android.intent.action.VIEW -d "pg://debug"
```

#### Custom URL schemes on iOS

```shell
/usr/bin/xcrun simctl openurl booted "pg://debug"
```
