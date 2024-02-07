
get:
	echo "╠ Installing dependencies..."
	flutter pub get

outdated:
	echo "╠ Resolving dependencies..."
	flutter pub outdated

clean: ## Cleans the environment
	echo "╠ Cleaning the project..."
	flutter clean
	echo "╠ Installing dependencies..."
	flutter pub get

install: ## Installing ios dependencies
	echo "╠ Resolving ios dependencies..."
	cd ios && pod install && cd ..

icon: ## Generate icons
	echo "╠ Generate icons..."
	dart run flutter_native_splash:create

build_watch: ## Watches the files for changes
	echo "╠ Watching the project..."
	dart run build_runner watch --delete-conflicting-outputs

build_runner: ## Build the files for changes
	echo "╠ Building the project..."
	dart run build_runner build --delete-conflicting-outputs

clean_runner: ## Deleting cache and generated source files
	echo "╠ Deleting cache and generated source files..."
	dart run build_runner clean

internal_apk: ## Release Apk
	echo "╠ Releasing Apk..."
	bash build-android.sh && flutter build apk --no-tree-shake-icons --flavor internalStaging --target lib/main_internal.dart

internal_appbundle: ## Release Appbundle
	echo "╠ Releasing Appbundle..."
	flutter build appbundle --no-tree-shake-icons --flavor internalProduction --target lib/main_internal.dart

external_apk: ## Release Apk
	echo "╠ Releasing Apk..."
	bash build-android.sh && flutter build apk --no-tree-shake-icons --flavor externalStaging --target lib/main_external.dart

external_appbundle: ## Release Appbundle
	echo "╠ Releasing Appbundle..."
	flutter build appbundle --no-tree-shake-icons --flavor externalProduction --target lib/main_external.dart

internal_adhoc:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to adhoc..."
	bash build-ios.sh && flutter build ipa --flavor internal --target lib/main_internal.dart --export-options-plist=ios/ExportOptions-internal-debug.plist --dart-define-from-file=versioning.json

internal_appstore:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to app store..."
	flutter build ipa --flavor internal --target lib/main_internal.dart --export-options-plist=ios/ExportOptions-internal-release.plist

external_adhoc:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to adhoc..."
	bash build-ios.sh && flutter build ipa --flavor external --target lib/main_external.dart --export-options-plist=ios/ExportOptions-external-debug.plist --dart-define-from-file=versioning.json

external_appstore:
	echo "╠ Removing build products and intermediate files from the build root..."
	cd ios && xcodebuild clean && cd ..
	echo "╠ Releasing to app store..."
	flutter build ipa --flavor external --target lib/main_external.dart --export-options-plist=ios/ExportOptions-external-release.plist
