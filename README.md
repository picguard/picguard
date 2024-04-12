# PicGuard

[![Test](https://github.com/picguard/picguard/actions/workflows/test.yml/badge.svg)](https://github.com/picguard/picguard/actions/workflows/test.yml)
[![Release](https://github.com/picguard/picguard/actions/workflows/release.yml/badge.svg)](https://github.com/picguard/picguard/actions/workflows/release.yml)

> Your pictures, your signature.

## iOS

```shell
# 导入证书
security import ./<name>.cer -P <password> -A -t cert

# 导入.p12私钥
security import ./<name>.p12 -P <password> -A -t cert -f pkcs12

# 双击导入mobileprovision文件
```

> 手动安装模拟器运行时

```shell

# 已安装列表
xcrun simctl runtime list

# 安装
xcrun simctl runtime add "~/iOS_17.0.1_Simulator_Runtime.dmg"
```

## Tests

### Deep Links on Android

```shell
adb shell am start -a android.intent.action.VIEW -d "pg://debug"
```

### Custom URL schemes on iOS

```shell
/usr/bin/xcrun simctl openurl booted "pg://debug"
```
