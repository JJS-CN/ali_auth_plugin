package com.example.ali_auth_plugin

import androidx.annotation.NonNull
import com.mobile.auth.gatewayauth.PhoneNumberAuthHelper
import com.mobile.auth.gatewayauth.TokenResultListener
import com.mobile.auth.gatewayauth.AuthUIConfig
import android.graphics.Color
import android.content.Context
import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject

/** AliAuthPlugin */
class AliAuthPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ali_auth_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "getSdkVersion") {
            //获取SDK版本号
            val version = PhoneNumberAuthHelper.getVersion();
            result.success(version)
        } else if (call.method == "setAuthSDKInfo") {
            //设置签名
            PhoneNumberAuthHelper.getInstance(context, null)
                .setAuthSDKInfo((call.arguments as Map<*, *>)["androidAppSecret"].toString())
        } else if (call.method == "checkEnvAvailable") {
            //检查环境
            PhoneNumberAuthHelper
                .getInstance(context, object : TokenResultListener {
                    override fun onTokenSuccess(p0: String?) {
                        result.success(true)
                    }

                    override fun onTokenFailed(p0: String?) {
                        result.error("", "onTokenFailed", p0)
                    }
                })
                .checkEnvAvailable(PhoneNumberAuthHelper.SERVICE_TYPE_LOGIN);
        } else if (call.method == "getLoginToken") {
            //获取登录Token, 唤起一键登陆页
            val authHelper = PhoneNumberAuthHelper
                .getInstance(context, object : TokenResultListener {
                    override fun onTokenSuccess(p0: String?) {
                        val jsonObject = JSONObject(p0);
                        val token = jsonObject.get("token")
                        result.success(token)
                        //不管成功失败,直接关闭
                        PhoneNumberAuthHelper
                            .getInstance(context, null)
                            .quitLoginPage()
                    }

                    override fun onTokenFailed(p0: String?) {
                        result.error("", "onTokenFailed", p0)
                        //不管成功失败,直接关闭
                        PhoneNumberAuthHelper
                            .getInstance(context, null)
                            .quitLoginPage()
                    }
                })
            //点击范围扩大
            authHelper.expandAuthPageCheckedScope(true)
            if (call.arguments != null && call.arguments.toString().length > 0) {
                val conf = JSONObject(call.arguments.toString());
                val builder = AuthUIConfig.Builder()
                //隐藏默认切换其他登录方式
                builder.setSwitchAccHidden(true)
                conf["navColor"]?.let {
                    builder.setNavColor(Color.parseColor(it.toString()))
                    builder.setStatusBarColor(Color.parseColor(it.toString()))
                    builder.setWebViewStatusBarColor(Color.parseColor(it.toString()))
                }
                conf["lightColor"]?.let {
                    builder.setLightColor(it as Boolean)
                }
                conf["navTextColor"]?.let {
                    builder.setNavTextColor(Color.parseColor(it.toString()))
                }
                conf["navReturnImgPath"]?.let {
                    builder.setNavReturnImgPath(it.toString())
                }
                conf["logoImgPath"]?.let {
                    builder.setLogoImgPath(it.toString())
                }
                conf["logBtnBackgroundPath"]?.let {
                    builder.setLogBtnBackgroundPath(it.toString())
                }
                conf["logBtnTextColor"]?.let {
                    builder.setLogBtnTextColor(Color.parseColor(it.toString()))
                }
                conf["checkedImgPath"]?.let {
                    builder.setCheckedImgPath(it.toString())
                }
                conf["uncheckedImgPath"]?.let {
                    builder.setUncheckedImgPath(it.toString())
                }
                conf["appPrivacyColor"]?.let {
                    if (it.toString().length >= 7) {
                        builder.setAppPrivacyColor(Color.LTGRAY, Color.parseColor(it.toString()))
                    }
                }
                val uiconfig = builder.create()
                authHelper.setAuthUIConfig(uiconfig)
            }

            authHelper.getLoginToken(context, 10000);
        } else if (call.method == "quitLoginPage") {
            //退出一键登录页
            PhoneNumberAuthHelper
                .getInstance(context, null)
                .quitLoginPage()
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
