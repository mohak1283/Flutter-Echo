package com.example.echo;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.util.Log;
import android.widget.Toast;

import com.karumi.dexter.Dexter;
import com.karumi.dexter.PermissionToken;
import com.karumi.dexter.listener.PermissionDeniedResponse;
import com.karumi.dexter.listener.PermissionGrantedResponse;
import com.karumi.dexter.listener.PermissionRequest;
import com.karumi.dexter.listener.single.PermissionListener;

import androidx.core.app.ActivityCompat;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;

public class MainActivity extends FlutterActivity {
  /* access modifiers changed from: protected */
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new FlutterView(this);
    new MethodChannel(getFlutterView(), "samples.flutter/call").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        StringBuilder sb = new StringBuilder();
        sb.append("result is ");
        sb.append(result);
        Log.e("Main", sb.toString());
        if (methodCall.method.equals("callUser")) {
          result.success("fe");
          MainActivity.this.callUser();
        } else if (methodCall.method.equals("sendMessage")) {
          result.success("fd");
          MainActivity.this.sendSMS();
        } else {
          result.notImplemented();
        }
      }
    });
  }

  /* access modifiers changed from: 0000 */
  public String callUser() {
    Intent intent = new Intent("android.intent.action.CALL");
    intent.setData(Uri.parse("tel:+918448213061"));
    if (ActivityCompat.checkSelfPermission(this, "android.permission.CALL_PHONE") != 0) {
      return null;
    }
    startActivity(intent);
    return null;
  }

  public void sendSMS() {
    Dexter.withActivity(this).withPermission("android.permission.SEND_SMS").withListener(new PermissionListener() {
      public void onPermissionGranted(PermissionGrantedResponse response) {
        try {
          SmsManager.getDefault().sendTextMessage("+918700753862", null, "Need Help", null, null);
          Toast.makeText(MainActivity.this, "Message Sent", Toast.LENGTH_SHORT).show();
        } catch (Exception ex) {
          Toast.makeText(MainActivity.this, ex.getMessage(), Toast.LENGTH_SHORT).show();
          ex.printStackTrace();
        }
      }

      public void onPermissionDenied(PermissionDeniedResponse response) {
      }

      public void onPermissionRationaleShouldBeShown(PermissionRequest permission, PermissionToken token) {
      }
    }).check();
  }
}
