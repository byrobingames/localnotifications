package com.byrobin.Notification;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.ApplicationInfo;


import org.haxe.extension.Extension;

import me.leolin.shortcutbadger.ShortcutBadger;

import android.view.Window;


public class NCReceiver extends BroadcastReceiver {
    
    public int iconID;
    public PendingIntent contentIntent;
    
    // Called when a broadcast is made targeting this class
    @Override
    public void onReceive(Context arg0, Intent arg1)
    {
        
        SharedPreferences sharedPref= arg0.getSharedPreferences("com.byrobin.Notification",Context.MODE_WORLD_READABLE);
        String msg = sharedPref.getString("msg", "");

        createNotification(arg0, msg);
    }

    public void createNotification(Context context, String message)
    {

        NotificationManager mNotificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

        String tickerText = "You have a new message from ::APP_TITLE::";
        String contentTitle = "::APP_TITLE::";
        String contentText = message;
        
        PackageManager pm = context.getPackageManager();
        String pkg = "::APP_PACKAGE::";
        
        try {
            ApplicationInfo ai = pm.getApplicationInfo(pkg, 0);
            iconID = ai.icon;
        } catch (NameNotFoundException e) {
            iconID = android.R.drawable.ic_dialog_info;
        }

        long when = System.currentTimeMillis();
            
        //Intent notificationIntent = new Intent(context, Extension.mainActivity.getClass());
       // PendingIntent contentIntent = PendingIntent.getActivity(context, 0, notificationIntent, 0);
        
        PendingIntent contentIntent= PendingIntent.getActivity(context.getApplicationContext(), 0, new Intent(), 0);
        
        Notification notification = new Notification(iconID, tickerText, when);
        notification.setLatestEventInfo(context, contentTitle, contentText, contentIntent);
        notification.defaults |= Notification.DEFAULT_SOUND;
        notification.defaults |= Notification.DEFAULT_VIBRATE;
        notification.flags |= Notification.FLAG_AUTO_CANCEL;
    
        mNotificationManager.notify(1, notification);
        
        //set badge number
        
        SharedPreferences sharedPref= context.getSharedPreferences("com.byrobin.Notification",Context.MODE_WORLD_READABLE);
        int badgeCount = sharedPref.getInt("badge", 0);
        
        badgeCount++;
 
        SharedPreferences.Editor editor= sharedPref.edit();
        editor.putInt("badge",badgeCount);
        editor.commit();
        
        ShortcutBadger.with(context.getApplicationContext()).count(badgeCount);

    }
    
}
