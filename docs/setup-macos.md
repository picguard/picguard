# Setup macOS

## Requirements

> Requires a .p12 file containing the certificate

1. The build target is in `dmg` format and the certificate type is `Developer ID Application`

2. The build target is in `pkg` format and the certificate types are `Developer ID Application` and `Developer ID Installer`

3. The build target is in `pkg` format, distributed to Mac App Store, and the certificate types are `Mac App Distribution` and `Mac Installer Distribution`

4. The build target is in `zip` format and the certificate type is `Developer ID Application`

## Release

```shell
make ENV=<dev|stg|prod> <macos_free|macos_pro>
```

## Code Signing

```shell
# build & sign pkg
# developer id installer
xcrun pkgbuild --component "./PicGuard.app" --install-location /Applications --sign "" PicGuard.pkg

# Notarize pkg
xcrun notarytool submit --verbose PicGuard.pkg --apple-id "" --team-id "" --password ""
xcrun notarytool info <id> --apple-id "" --team-id "" --password ""
xcrun notarytool log <id> --apple-id "" --team-id "" --password ""
```
