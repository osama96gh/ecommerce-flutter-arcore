package com.og.ecommerce_arcore

import android.content.Intent
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.og.ecommerce_arcore/ar"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            // Note: this method is invoked on the main thread.
            if (call.method == "startArActivity") {
                var data = call.arguments as Map<String, Any>;
                val intent = Intent(this, ArActivity::class.java)
// To pass any data to next activity
                intent.putExtra("url", data["url"] as String)
                intent.putExtra("type", data["type"] as Int)
// start your next activity
                startActivity(intent)

                Toast.makeText(getApplicationContext(), "ar android", Toast.LENGTH_LONG).show();
                if (1 != -1) {
                    result.success("supported")
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
