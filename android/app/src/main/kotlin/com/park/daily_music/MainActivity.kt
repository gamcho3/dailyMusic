package com.park.daily_music

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "SHARE_URL";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call,result ->
            if(call .method == "getYoutubeUrl"){
                var youtubeUrl:String = getUrl();
                if(youtubeUrl != "empty"){
                    result.success(youtubeUrl);
                }
            }else{
                result.notImplemented();
            }

        }
    }

    private fun getUrl(): String{
        val intent = intent
        val action = intent.action
        val type = intent.type

        if (Intent.ACTION_SEND == action && type != null) {
            if ("text/plain" == type) {
                val sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
                // sharedText 변수에 공유된 텍스트가 저장됩니다.
                return sharedText.toString();
            }
        }
        return "empty";
    }
}
