package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#else
import openfl.Lib;
#end

#if android
#if openfl_legacy
import openfl.utils.JNI;
#else
import lime.system.JNI;
#end
#end

import openfl.Assets;

class Notifications
{
    #if ios 
    
    private static var setIconBadgeNumber = Lib.load("notifications","set_icon_badge_number",1);
    private static var increaseIconBadgeNumberBy = Lib.load("notifications","increase_icon_badge_number",1);
    private static var decreaseIconBadgeNumberBy = Lib.load("notifications","decrease_icon_badge_number",1);
    private static var cancelLocalNotifications = Lib.load("notifications", "cancel_local_notifications", 0);
    private static var cancelLocalNotificationsWithId = Lib.load("notifications","cancel_local_notifications_withid",1);
    private static var scheduleLocalNotification = Lib.load("notifications","schedule_local_notification",1);
	
    #end
	
	#if android
	private static var scheduleLocalNotification:Dynamic;
	private static var setIconBadgeNumber:Dynamic;
	private static var increaseIconBadgeNumberBy:Dynamic;
	private static var decreaseIconBadgeNumberBy:Dynamic;
	private static var cancelLocalNotifications:Dynamic;
	private static var cancelLocalNotificationsWithId:Dynamic;
	
	#end
	
	
    public static function hxSetIconBadgeNumber(number:Int = 0):Void
    {
		#if ios
        setIconBadgeNumber(number);
		#end
		
		#if android
		 if(setIconBadgeNumber == null)
            {
                setIconBadgeNumber = JNI.createStaticMethod("com.byrobin.notification.NotificationsExtension", "setApplicationIconBadgeNumber", "(I)Z", true);
            }
            var args = new Array<Dynamic>();
            args.push(number);
            setIconBadgeNumber(args);
		#end
    }
    
    public static function hxIncreaseIconBadgeNumberBy(number:Int = 0):Void
    {
		#if ios
        increaseIconBadgeNumberBy(number);
		#end
		
		#if android
		if(increaseIconBadgeNumberBy == null)
            {
                increaseIconBadgeNumberBy = JNI.createStaticMethod("com.byrobin.notification.NotificationsExtension", "increaseIconBadge", "(I)Z", true);
            }
            var args = new Array<Dynamic>();
            args.push(number);
            increaseIconBadgeNumberBy(args);
		#end
    }
    
    public static function hxDecreaseIconBadgeNumberBy(number:Int = 0):Void
    {
		trace("decreaseIconBadgeNumberBy0");
		#if ios
        decreaseIconBadgeNumberBy(number);
		#end
		
		#if android
		trace("decreaseIconBadgeNumberBy1");
		if(decreaseIconBadgeNumberBy == null)
            {
				trace("decreaseIconBadgeNumberBy2");
                decreaseIconBadgeNumberBy = JNI.createStaticMethod("com.byrobin.notification.NotificationsExtension", "decreaseIconBadge", "(I)Z", true);
            }
            var args = new Array<Dynamic>();
            args.push(number);
            decreaseIconBadgeNumberBy(args);
		#end
    }
    
    public static function hxCancelLocalNotifications():Void
    {
		#if ios
        cancelLocalNotifications();
		#end
		
		#if android
		if(cancelLocalNotifications == null)
            {
                cancelLocalNotifications = JNI.createStaticMethod("com.byrobin.notification.NotificationsExtension", "cancelAllNotification", "()V", true);
            }
            var args = new Array<Dynamic>();
            cancelLocalNotifications();
		#end
    }
	
	public static function hxCancelLocalNotificationsWithId(notifid:Int):Void
    {
		#if ios
        cancelLocalNotificationsWithId(notifid);
		#end
		
		#if android
		if(cancelLocalNotificationsWithId == null)
            {
                cancelLocalNotificationsWithId = JNI.createStaticMethod("com.byrobin.notification.NotificationsExtension", "cancelNotificationInSlot", "(I)V", true);
            }
            var args = new Array<Dynamic>();
			args.push(notifid);
            cancelLocalNotificationsWithId(args);
		#end
    }
    
   public static function hxScheduleLocalNotification():Void
	{
		var jsonString = Assets.getText("assets/data/com.byrobingames.manager/notif.json");
		
		trace("Testing jsonstring" + jsonString);
		
		#if ios
		scheduleLocalNotification(jsonString);
		#end
		
		#if android

        if(scheduleLocalNotification == null)
        {
			scheduleLocalNotification = JNI.createStaticMethod("com.byrobin.notification.NotificationsExtension", "scheduleNotification", "(Ljava/lang/String;)V", true);
        }
        var args = new Array<Dynamic>();
		args.push(jsonString);
        scheduleLocalNotification(args);
        #end
    }
   
}
