package com.byrobin.notification;

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
import android.support.v4.app.NotificationCompat;
import android.support.v4.app.NotificationCompat.Builder;
import android.view.Window;
import android.util.Log;
import java.lang.Math;
import org.haxe.extension.Extension;

import com.byrobin.notification.Common;

public class BootReceiver extends BroadcastReceiver {
	@Override
	public void onReceive(Context context, Intent intent) {
		if(context == null || intent == null) {
			Log.i(Common.TAG, "Received boot broadcast with null context or intent");
			return;
		}
		String action = intent.getAction();
		if(action == null) {
			Log.i(Common.TAG, "Received boot broadcast with null action");
			return;
		}
		
		registerAlarmsPostBoot(context);
		
		// Set the last known badge number on the app icon at boot, in case it was forgotten between reboots
		Common.setApplicationIconBadgeNumber(context, Common.getApplicationIconBadgeNumber(context));
	}
	
	private static void registerAlarmsPostBoot(Context context) {
		Common.pendingIntents.clear(); // Clear out the pending intents, precaution in case spurious/multiple post-boot events are received somehow
		
		Long currentTime = System.currentTimeMillis();
		
		// Alarm re-registration. This is required because alarms are cleared when the device is turned off or rebooted
		Log.i(Common.TAG, "Re-registering application notifications on boot");
		for(int slot = 0; slot < Common.MAX_NOTIFICATION_SLOTS; slot++) {
			SharedPreferences prefs = Common.getNotificationSettings(context, slot);
			if(prefs == null) {
				continue;
			}
			Long alertTime = prefs.getLong(Common.UTC_SCHEDULED_TIME, -1);
			if(alertTime == -1) {
				continue; // Skip unreadable/not-set notification data
			}
			if(alertTime - currentTime < 0) {
				// Reschedule notifications whose time passed while the phone was powered off to the very-near future, preserving order
				double overdueByMillis = Math.abs(alertTime - currentTime);
				double orderPreservingDelay = 100 + (1000 / (1 + Math.log10(overdueByMillis + 1)));
				alertTime = currentTime + Double.valueOf(orderPreservingDelay).longValue();
			}
			
			String title = prefs.getString(Common.TITLE_TEXT_TAG, "");
			String message = prefs.getString(Common.MESSAGE_BODY_TEXT_TAG, "");
            int repeat = prefs.getInt(Common.REPEAT_TIME, 0);
			
			PendingIntent intent = Common.scheduleLocalNotification(context, slot, title, message, alertTime, repeat);
            
			Common.pendingIntents.put(slot, intent);
		}
	}
}
