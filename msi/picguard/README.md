# Quick Start

## Environment Variables

platform: x86, x64, arm64

### Local Development

```powershell
$env:Platform = "x64"
$env:IconPath = "$pwd\windows\runner\resources\app_icon.ico"
$env:FLUTTER_BUILD_OUTPUT_DIR = "$pwd\build\windows\$env:Platform\runner\Release"
```

### Github Action

```powershell
$env:Platform = "x64"
$env:IconPath = "$pwd\windows\runner\resources\app_icon.ico"
$env:FLUTTER_BUILD_OUTPUT_DIR = "$pwd\build\windows\$env:Platform\runner\Release"
```

## Build

```powershell
heat dir "$pwd\build\windows\$env:Platform\runner\Release\data\flutter_assets\fonts" -cg AssetComponents -gg -o "$pwd\msi\picguard\picguard\AppFonts.wxs"
```

```powershell
dotnet build .\msi\picguard\picguard\picguard.wixproj --arch "$env:Platform" --configuration Release
```

## Output

configuration: Debug, Release

msi\picguard\picguard\bin\$env:Platform\${configuration}\en-US

## Debug

```text
<DefineConstants>FlutterBuildOutputDir=..\..\..\build\windows\x64\runner\Release</DefineConstants>
```
