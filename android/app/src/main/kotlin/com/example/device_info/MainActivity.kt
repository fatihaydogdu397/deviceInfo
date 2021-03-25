package com.example.device_info


import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {
    private val deviceInfo = "samples.flutter.dev/deviceInfo"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, deviceInfo).setMethodCallHandler {
            call, result ->

            if (call.method.equals("deviceInfo")) {
                val batteryLevel = getBatteryLevel()
                fun putritanjungsari(build: Map<String, Any?>){
                }
                val build: Map<String,Any?> = mapOf(
                "battery" to batteryLevel,
                "board" to Build.BOARD,
                "bootloader" to Build.BOOTLOADER,
                "brand" to Build.BRAND,
                "device" to Build.DEVICE,
                "fingerprint" to Build.FINGERPRINT,
                "hardware" to Build.HARDWARE,
                "host" to Build.HOST,
                "id" to Build.ID,
                "manufacturer" to Build.MANUFACTURER,
                "model" to Build.MODEL,
                "product" to Build.PRODUCT,
                "tags" to Build.TAGS,
                "type" to Build.TYPE
                )
                result.success(build)
            } else {
                result.notImplemented()
            }
        }


    }

   private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }


   

}
