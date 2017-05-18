package com.byrobin.notification;

import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import java.lang.Integer;
import java.lang.System;
import android.util.Log;
import android.os.*;

import java.util.GregorianCalendar;
import java.util.Map;


import me.leolin.shortcutbadger.ShortcutBadger;
import org.haxe.extension.Extension;

import com.byrobin.notification.Common;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;

public class NotificationsExtension extends Extension {
    
    public static void scheduleNotification(String jsonString){
        Log.i(Common.TAG,"scheduleLocalNotification: "+jsonString);
        
        try
        {
            JSONArray json = new JSONArray(jsonString);
        
            if(json.length() != 0){
                for (int i=0; i < json.length(); i++) {
                    Log.i(Common.TAG,"JSONArray: " + json.get(i));
                    JSONArray ja = new JSONArray(json.get(i).toString());
            
                    int slot = Integer.valueOf(ja.get(0).toString());
                    String title = ja.get(1).toString();
                    String message = ja.get(2).toString();
                    int triggerAfterSecs = Integer.valueOf(ja.get(3).toString());
                    String repeat = ja.get(4).toString();
                
                    // Define a time value of seconds
                    Long alertTime = new GregorianCalendar().getTimeInMillis()+triggerAfterSecs*1000;
                
                    Common.writePreference(mainContext, slot, title, message, alertTime, getInterval(repeat));
                    PendingIntent intent = Common.scheduleLocalNotification(mainContext, slot, title, message, alertTime, getInterval(repeat));
                
                    Common.pendingIntents.put(slot, intent);
                }
            }
        }
        catch (JSONException e)
        {
            e.printStackTrace();
            Log.i(Common.TAG,e.toString());
            
        }
	}
    
    private static int getInterval(String repeat){
        
        int seconds = 0;
        
        if(repeat.equals("Minute")){// minute
            
            seconds = 60;
            
        }else if(repeat.equals("Hour")){// hour
            
            seconds = 60 * 60;
            
        }else if(repeat.equals("Day")){// day
            
            seconds = 60 * 60 * 24;
            
        }else if(repeat.equals("`Week")){// week
            
            seconds = 60 * 60 * 24 * 7;
            
        }else if(repeat.equals("Month")){// month
            
            seconds = 60 * 60 * 24 * 7 * 4;
            
        }else if(repeat.equals("Year")){// year
            
            seconds = 60 * 60 * 24 * 7 * 4 * 12;
            
        }else{
            seconds = 0;
        }
        
        int milliseconds = 1000;
        int repeatMS = seconds * 1 * milliseconds;
        return repeatMS;
    }
	
	public static void cancelNotificationInSlot(int slot) {
		Log.i(Common.TAG, "Cancelling local notification");
		
		NotificationManager notificationManager = ((NotificationManager)mainContext.getSystemService(Context.NOTIFICATION_SERVICE));
		if(notificationManager != null) {
			notificationManager.cancel(slot);
		}
		
		AlarmManager alarmManager = ((AlarmManager)mainContext.getSystemService(Context.ALARM_SERVICE));
		PendingIntent intent = Common.pendingIntents.get(slot);
		if(intent != null && alarmManager != null) {
			alarmManager.cancel(intent);
		} else {
			Log.i(Common.TAG, "Failed to remove notification from alarmManager, was it scheduled in the first place?");
		}
		Common.pendingIntents.remove(slot);
		Common.erasePreference(mainContext, slot);
	}
	
	public static void cancelAllNotification() {
		Log.i(Common.TAG, "Cancelling all local notifications");
		
		NotificationManager notificationManager = ((NotificationManager)mainContext.getSystemService(Context.NOTIFICATION_SERVICE));
		if(notificationManager != null) {
			notificationManager.cancelAll();
		}
		
		AlarmManager alarmManager = ((AlarmManager)mainContext.getSystemService(Context.ALARM_SERVICE));
		for (Map.Entry<Integer, PendingIntent> entry : Common.pendingIntents.entrySet()) {
			PendingIntent intent = entry.getValue();
			if(intent != null && alarmManager != null) {
				alarmManager.cancel(intent);
			}
			Integer slot = entry.getKey();
			Common.erasePreference(mainContext, slot);
		}
		Common.pendingIntents.clear();
	}
	
	public static int getApplicationIconBadgeNumber() {
		return Common.getApplicationIconBadgeNumber(mainContext);
	}
	
	public static boolean setApplicationIconBadgeNumber(int number) {
		return Common.setApplicationIconBadgeNumber(mainContext, number);
	}
    
    public static boolean increaseIconBadge(int number)
    {
        Log.i(Common.TAG, "increaseIconBadge");
        int badge = getApplicationIconBadgeNumber() + number;
        
        return setApplicationIconBadgeNumber(badge);
    }
    
    public static boolean decreaseIconBadge(int number)
    {
        Log.i(Common.TAG, "decreaseIconBadge");
        int badge = getApplicationIconBadgeNumber() -+ number;
        
        return setApplicationIconBadgeNumber(badge);
    }
    
    public void onCreate (Bundle savedInstanceState)
    {
        Log.i(Common.TAG,"onCreate");
        
        if(getApplicationIconBadgeNumber() >0){
            setApplicationIconBadgeNumber(0);
        }
        super.onCreate(savedInstanceState);
    }
    
    
    public void onStart()
    {
        Log.i(Common.TAG,"onStart");
        if(getApplicationIconBadgeNumber() >0){
            setApplicationIconBadgeNumber(0);
        }
        super.onStart();
    }
    
    
    public void onResume()
    {
        Log.i(Common.TAG,"onResume");
        if(getApplicationIconBadgeNumber() >0){
            setApplicationIconBadgeNumber(0);
        }
        super.onResume();
        
    }
    
    public void onRestart()
    {
        Log.i(Common.TAG,"onRestart");
        if(getApplicationIconBadgeNumber() >0){
            setApplicationIconBadgeNumber(0);
        }
        super.onRestart();
    }
}
