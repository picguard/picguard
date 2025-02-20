
get:
	echo "╠ Installing dependencies..."
	fvm flutter pub get

outdated:
	echo "╠ Resolving dependencies..."
	fvm flutter pub outdated

sorter:
	echo "╠ Sorting imports..."
	fvm dart run import_sorter:main lib\/* test\/*

clean: ## Cleans the environment
	echo "╠ Cleaning the project..."
	fvm flutter clean
	echo "╠ Installing dependencies..."
	make get

install:
	make ios_install
	make macos_install

ios_install: ## Installing ios dependencies
	echo "╠ Resolving ios dependencies..."
	cd ios && pod install && cd ..

macos_install: ## Installing ios dependencies
	echo "╠ Resolving macos dependencies..."
	cd macos && pod install && cd ..

precache: ## Installing ios dependencies
	echo "╠ Populate the Flutter tool's cache of binary artifacts..."
	fvm flutter precache -a

icon: ## Generate icons
	echo "╠ Generate icons..."
	fvm dart run flutter_native_splash:create

build_watch: ## Watches the files for changes
	echo "╠ Watching the project..."
	fvm dart run build_runner watch --delete-conflicting-outputs

build_runner: ## Build the files for changes
	echo "╠ Building the project..."
	fvm dart run build_runner build --delete-conflicting-outputs

clean_runner: ## Deleting cache and generated source files
	echo "╠ Deleting cache and generated source files..."
	fvm dart run build_runner clean

apk_free: ## Release Apk for Free
	echo "╠ Releasing Apk..."
	fvm flutter build apk --no-tree-shake-icons --dart-define-from-file=".env.$(ENV).local" --target lib/main_free.dart --flavor freeStaging

appbundle_free: ## Release Appbundle for free
	echo "╠ Releasing Appbundle..."
	fvm flutter build appbundle --no-tree-shake-icons --dart-define-from-file=".env.$(ENV).local" --target lib/main_free.dart --flavor freeProduction

apk_pro: ## Release Apk for Pro
	echo "╠ Releasing Apk..."
	fvm flutter build apk --no-tree-shake-icons --dart-define-from-file=".env.$(ENV).local" --target lib/main_pro.dart --flavor proStaging

appbundle_pro: ## Release Appbundle for Pro
	echo "╠ Releasing Appbundle..."
	fvm flutter build appbundle --no-tree-shake-icons --dart-define-from-file=".env.$(ENV).local" --target lib/main_pro.dart --flavor proProduction

adhoc_free:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to adhoc..."
	fvm flutter build ipa --dart-define-from-file=".env.$(ENV).local" --target lib/main_free.dart --export-options-plist=ios/ExportOptions/free/debug.plist

appstore_free:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to app store..."
	fvm flutter build ipa --dart-define-from-file=".env.$(ENV).local" --target lib/main_free.dart --export-options-plist=ios/ExportOptions/free/release.plist

adhoc_pro:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to adhoc..."
	fvm flutter build ipa --dart-define-from-file=".env.$(ENV).local" --target lib/main_pro.dart --flavor pro --export-options-plist=ios/ExportOptions/pro/debug.plist

appstore_pro:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to app store..."
	fvm flutter build ipa --dart-define-from-file=".env.$(ENV).local" --target lib/main_pro.dart --flavor pro --export-options-plist=ios/ExportOptions/pro/release.plist

macos_free:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd macos && xcodebuild clean && cd ..
	echo "╠ Releasing bundle..."
	fvm flutter build macos --dart-define-from-file=".env.$(ENV).local" --target lib/main_free.dart

macos_pro:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd macos && xcodebuild clean && cd ..
	echo "╠ Releasing bundle..."
	fvm flutter build macos --dart-define-from-file=".env.$(ENV).local" --target lib/main_pro.dart --flavor pro

web_free:
	echo "╠ Releasing web..."
	fvm flutter build web --dart-define-from-file=".env.$(ENV).local" --target lib/main_free.dart

web_dev:
	echo "╠ Releasing web..."
	fvm flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080 --dart-define-from-file=".env.$(ENV).local" --target lib/main_free.dart
