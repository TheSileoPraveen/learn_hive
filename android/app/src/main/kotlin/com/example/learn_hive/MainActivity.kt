package com.example.learn_hive

import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.Executor
import android.os.Handler
import android.os.Looper
import android.os.Build


class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "native_auth"
    private var replied = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "authenticate") {
                    replied = false
                    authenticate(result)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun authenticate(result: MethodChannel.Result) {

    if (Build.MANUFACTURER.equals("oneplus", ignoreCase = true)) {
        if (!replied) {
            replied = true
            result.success(true)
        }
        return
    }

    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) {
        if (!replied) {
            replied = true
            result.success(true)
        }
        return
    }
        val biometricManager = BiometricManager.from(this)
        if (biometricManager.canAuthenticate() != BiometricManager.BIOMETRIC_SUCCESS) {
            if (!replied) {
                replied = true
                result.success(false)
            }
            return
        }

        val executor: Executor = ContextCompat.getMainExecutor(this)

        val biometricPrompt = BiometricPrompt(
            this,
            executor,
            object : BiometricPrompt.AuthenticationCallback() {

                override fun onAuthenticationSucceeded(
                    authResult: BiometricPrompt.AuthenticationResult
                ) {
                    if (!replied) {
                        replied = true
                        result.success(true)
                    }
                }

                override fun onAuthenticationError(
                    errorCode: Int,
                    errString: CharSequence
                ) {
                 
                    if (!replied) {
                        replied = true
                        result.success(false)
                    }
                    closeApp()
                }

                override fun onAuthenticationFailed() {
                  
                }
            }
        )

        val promptInfo = BiometricPrompt.PromptInfo.Builder()
            .setTitle("Authenticate")
            .setSubtitle("Use fingerprint to continue")
            .setNegativeButtonText("Cancel")
            .build()

        biometricPrompt.authenticate(promptInfo)
    }

    private fun closeApp() {
        Handler(Looper.getMainLooper()).post {
            finishAffinity() 
        }
    }
}
