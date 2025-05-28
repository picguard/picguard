plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
import java.io.FileInputStream

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

val proKeystorePropertiesFile = rootProject.file("key-pro.properties")
val proKeystoreProperties = Properties()
if (proKeystorePropertiesFile.exists()) {
    proKeystoreProperties.load(FileInputStream(proKeystorePropertiesFile))
}

android {
    namespace = "com.kjxbyz.picguard"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.2.12479018"
//    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    sourceSets.getByName("main") {
        java.setSrcDirs(listOf("src/main/java", "src/main/kotlin"))
    }

    defaultConfig {
        applicationId = "com.kjxbyz.picguard"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("free") {
            if (System.getenv("ANDROID_KEYSTORE_PATH") != null) {
                storeFile = file(System.getenv("ANDROID_KEYSTORE_PATH"))
                keyAlias = System.getenv("ANDROID_KEYSTORE_ALIAS")
                keyPassword = System.getenv("ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD")
                storePassword = System.getenv("ANDROID_KEYSTORE_PASSWORD")
            } else {
                keyAlias = keystoreProperties["keyAlias"] as String?
                keyPassword = keystoreProperties["keyPassword"] as String?
                storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
                storePassword = keystoreProperties["storePassword"] as String?
            }
        }
        create("pro") {
            if (System.getenv("ANDROID_KEYSTORE_PATH_PRO") != null) {
                storeFile = file(System.getenv("ANDROID_KEYSTORE_PATH_PRO"))
                keyAlias = System.getenv("ANDROID_KEYSTORE_ALIAS_PRO")
                keyPassword = System.getenv("ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD_PRO")
                storePassword = System.getenv("ANDROID_KEYSTORE_PASSWORD_PRO")
            } else {
                keyAlias = proKeystoreProperties["keyAlias"] as String?
                keyPassword = proKeystoreProperties["keyPassword"] as String?
                storeFile = proKeystoreProperties["storeFile"]?.let { file(it as String) }
                storePassword = proKeystoreProperties["storePassword"] as String?
            }
        }
    }

    flavorDimensions += listOf("default", "env")
    productFlavors {
        create("free") {
            dimension = "default"
            signingConfig = signingConfigs.getByName("free")
        }

        create("pro") {
            dimension = "default"
            applicationIdSuffix = ".pro"
            signingConfig = signingConfigs.getByName("pro")
        }

        create("staging") {
            dimension = "env"
            applicationIdSuffix = ".dev"
        }

        create("production") {
            dimension = "env"
        }
    }

    buildTypes {
        getByName("release") {
            isShrinkResources = true  // 移除未使用的资源
            isMinifyEnabled = true    // 启用 R8 代码压缩
            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro"
            )
        }
        getByName("debug") {
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    packagingOptions {
        jniLibs {
            // Enabling flag to compress JNI Libs to reduce APK size Ref: https://developer.android.com/topic/performance/reduce-apk-size?hl=zh-cn#extract-false
            useLegacyPackaging = true
        }
    }

    // Required by F-Droid
    dependenciesInfo {
        // Disables dependency metadata when building APKs.
        includeInApk = false
        // Disables dependency metadata when building Android App Bundles.
        includeInBundle = false
    }
}

flutter {
    source = "../.."
}

dependencies {}
