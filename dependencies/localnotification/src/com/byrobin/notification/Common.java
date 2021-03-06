package com.byrobin.notification;

import android.app.Activity;
import android.app.AlarmManager;
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
import android.os.Handler;
import android.os.Looper;
import android.os.*;
import android.view.Window;
import android.util.Log;
import java.lang.Runnable;
import java.util.concurrent.ConcurrentHashMap;

import java.util.Calendar;

import me.leolin.shortcutbadger.ShortcutBadger;

import com.byrobin.notification.NCReceiver;

import org.haxe.extension.Extension;

class Common {
	public static final String TAG = "LocalNotifications";
	
	// Maps pending intent ids to their corresponding intents.
	// Shared between the broadcastReceiver (that populates it with any pending intents at device boot) and Haxe-facing notification scheduling code
	public static ConcurrentHashMap<Integer, PendingIntent> pendingIntents = new ConcurrentHashMap<Integer, PendingIntent>();
	
	public static final int MAX_NOTIFICATION_SLOTS = 64; // Maximum number of notification action ids to manage (e.g. 10 -> .Notification0-9)
	
        // Tag used for keeping track of last application icon badge count
	public static final String LAST_BADGE_COUNT_TAG = "lastbadgecount";
	
	// Tags used for saving notification attributes to shared preferences for later use
        public static final String SLOT_TAG = "id";
        public static final String TITLE_TEXT_TAG = "titletext";
        public static final String MESSAGE_BODY_TEXT_TAG = "messagetext";
        public static final String UTC_SCHEDULED_TIME = "scheduledtime";
        public static final String REPEAT_TIME = "repeattime";
	
	public static String getPackageName() {
		return "::APP_PACKAGE::";
	}
	
	public static String getNotificationName(int slot) {
		return getPackageName() + ".Notification" + slot;
	}
	
	public static SharedPreferences getNotificationSettings(Context context, int slot) {
                return context.getSharedPreferences(getNotificationName(slot), Context.MODE_PRIVATE);
	}
    
    public static SharedPreferences getApplicationIconBadgeSettings(Context context) {
        return context.getSharedPreferences("notificationsiconbadge", Context.MODE_PRIVATE);
    }
	
	// Write notification data to preferences
        public static void writePreference(Context context, int slot, String title, String message, Long alertTime, int repeat) {
		SharedPreferences.Editor editor = getNotificationSettings(context, slot).edit();
		if(editor == null) {
			Log.i(TAG, "Failed to write notification to preferences");
			return;
		}

                editor.putInt(SLOT_TAG, slot);
                editor.putString(TITLE_TEXT_TAG, title);
                editor.putString(MESSAGE_BODY_TEXT_TAG, message);
                editor.putLong(UTC_SCHEDULED_TIME, alertTime);
                editor.putInt(REPEAT_TIME,repeat);
		boolean committed = editor.commit();
		
		if(!committed) {
			Log.i(TAG, "Failed to write notification to preferences");
		}
	}
	
	// Erase notification data from preferences
	public static void erasePreference(Context context, int slot) {
		SharedPreferences.Editor editor = getNotificationSettings(context, slot).edit();
		if(editor == null) {
			Log.i(TAG, "Failed to erase notification from preferences");
			return;
		}
		editor.clear();
		boolean committed = editor.commit();
		
		if(!committed) {
			Log.i(TAG, "Failed to erase notification from preferences");
		}
	}

	// Schedule a local notification
	public static PendingIntent scheduleLocalNotification(Context context, int slot, String title, String message, Long alertTime, int repeat) {
		Log.i(TAG, "Scheduling local notification");
		Intent alertIntent = new Intent(getNotificationName(slot));
                ::if (ANDROID_TARGET_SDK_VERSION >= 26)::
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    alertIntent.setClass(context, NCReceiver.class);
                }
                ::end::
        
		PendingIntent pendingIntent = PendingIntent.getBroadcast(context, slot, alertIntent, PendingIntent.FLAG_UPDATE_CURRENT);
        
		AlarmManager alarmManager = (AlarmManager)context.getSystemService(Context.ALARM_SERVICE);
		if(alarmManager != null) {
            if(repeat == 0){
                alarmManager.set(AlarmManager.RTC_WAKEUP, alertTime, pendingIntent);
            }else{
                Calendar alarmStartTime = Calendar.getInstance();
                alarmStartTime.add(Calendar.MINUTE, 1);
                alarmManager.setRepeating(AlarmManager.RTC_WAKEUP, alertTime, repeat, pendingIntent);
            }
		}
		return pendingIntent;
	}
	
	// Get application icon badge number
	public static int getApplicationIconBadgeNumber(Context context) {
		SharedPreferences prefs = getApplicationIconBadgeSettings(context);
		if(prefs == null) {
			Log.i(TAG, "Failed to retrieve application icon badge number");
			return 0;
		}
		Log.i(TAG, "Getting application icon badge number");
		return prefs.getInt(LAST_BADGE_COUNT_TAG, 0);
	}
	
	// Set application icon badge number
        public static boolean setApplicationIconBadgeNumber(final Context context, final int number) {

		SharedPreferences.Editor editor = getApplicationIconBadgeSettings(context).edit();
		if(editor == null) {
			Log.i(TAG, "Failed to set application icon badge number");
			return false;
		}
		editor.putInt(LAST_BADGE_COUNT_TAG, number);
		boolean committed = editor.commit();
		if(!committed) {
			Log.i(TAG, "Failed to record last known badge count to preferences");
			return false;
		}
		
		if(Looper.getMainLooper() == null) {
			Log.i(TAG, "Failed to get main looper?");
			return false;
		}
		
		if(number <= 0) {
			Log.i(TAG, "Clearing application icon badge number");
			new Handler(Looper.getMainLooper()).post(new Runnable() {
				@Override
				public void run() {
                                    //set iconbadgenumber deprecated in API 26 >
                                    if (ShortcutBadger.isBadgeCounterSupported(context)) {
                                        ShortcutBadger.removeCount(context);
                                     }
				}
			});
		} else {
			Log.i(TAG, "Setting application icon badge number");
			new Handler(Looper.getMainLooper()).post(new Runnable() {
				@Override
                                public void run() {
                                        //set iconbadgenumber deprecated in API 26 >
                                        if (ShortcutBadger.isBadgeCounterSupported(context)) {
                                            ShortcutBadger.applyCount(context, number);
                                        }
				}
			});
		}
		
		return true;
	}
}
