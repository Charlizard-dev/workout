package com.charlizard.charlizard

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

/**
 * Hosts the `charlizard/story_share` channel:
 * - isAppInstalled: package-visibility-safe install check (Android 11+).
 * - shareToInstagramStory / shareToFacebookStory: background-image story
 *   intents with FileProvider URIs; the Dart side falls back to the system
 *   share sheet when these return false.
 */
class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "charlizard/story_share"
        private const val INSTAGRAM_STORY_ACTION = "com.instagram.share.ADD_TO_STORY"
        private const val FACEBOOK_STORY_ACTION = "com.facebook.stories.ADD_TO_STORY"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isAppInstalled" -> {
                        val pkg = call.argument<String>("package")
                        result.success(pkg != null && isInstalled(pkg))
                    }
                    "shareToInstagramStory" -> {
                        val path = call.argument<String>("filePath")
                        val appId = call.argument<String>("applicationId") ?: ""
                        result.success(
                            path != null && shareStory(
                                action = INSTAGRAM_STORY_ACTION,
                                targetPackage = "com.instagram.android",
                                filePath = path,
                                applicationId = appId,
                            )
                        )
                    }
                    "shareToFacebookStory" -> {
                        val path = call.argument<String>("filePath")
                        val appId = call.argument<String>("applicationId") ?: ""
                        result.success(
                            path != null && shareStory(
                                action = FACEBOOK_STORY_ACTION,
                                targetPackage = "com.facebook.katana",
                                filePath = path,
                                applicationId = appId,
                            )
                        )
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun isInstalled(packageName: String): Boolean {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.getPackageInfo(
                    packageName,
                    PackageManager.PackageInfoFlags.of(0),
                )
            } else {
                @Suppress("DEPRECATION")
                packageManager.getPackageInfo(packageName, 0)
            }
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }

    private fun shareStory(
        action: String,
        targetPackage: String,
        filePath: String,
        applicationId: String,
    ): Boolean {
        if (!isInstalled(targetPackage)) return false
        return try {
            val file = File(filePath)
            val authority = "$packageName.fileprovider"
            val uri: Uri = FileProvider.getUriForFile(this, authority, file)
            val intent = Intent(action).apply {
                setDataAndType(uri, "image/png")
                setPackage(targetPackage)
                putExtra("interactive_asset_uri", uri)
                putExtra("com.instagram.share.APP_ID", applicationId)
                putExtra("com.facebook.platform.extra.APPLICATION_ID", applicationId)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
            // Verify a handler exists before launching.
            val resolved = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.resolveActivity(
                    intent,
                    PackageManager.ResolveInfoFlags.of(
                        PackageManager.MATCH_DEFAULT_ONLY.toLong(),
                    ),
                )
            } else {
                @Suppress("DEPRECATION")
                packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY)
            }
            if (resolved == null) return false
            startActivity(intent)
            true
        } catch (e: Exception) {
            false
        }
    }
}
