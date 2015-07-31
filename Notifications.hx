package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#else
import openfl.Lib;
#end

#if android
import openfl.utils.JNI;
#end

class Notifications
{
    #if ios 
    
    private static var setIconBadgeNumber = Lib.load("notifications","set_icon_badge_number",1);
    private static var increaseIconBadgeNumberBy = Lib.load("notifications","increase_icon_badge_number",1);
    private static var decreaseIconBadgeNumberBy = Lib.load("notifications","decrease_icon_badge_number",1);
    private static var cancelLocalNotifications = Lib.load("notifications","cancel_local_notifications",0);
    private static var scheduleLocalNotification = Lib.load("notifications","schedule_local_notification",3);
	
    #end
	
	#if android
	private static var scheduleLocalNotification:Dynamic;
	private static var setIconBadgeNumber:Dynamic;
	private static var increaseIconBadgeNumberBy:Dynamic;
	private static var decreaseIconBadgeNumberBy:Dynamic;
	private static var cancelLocalNotifications:Dynamic;
	
	#end
	
	
    public static function hxSetIconBadgeNumber(number:Int = 0):Void
    {
		#if ios
        setIconBadgeNumber(number);
		#end
		
		#if android
		 if(setIconBadgeNumber == null)
            {
                setIconBadgeNumber = JNI.createStaticMethod("com.byrobin.Notification.NotificationsExtension", "setIconBadge", "(I)V", true);
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
                increaseIconBadgeNumberBy = JNI.createStaticMethod("com.byrobin.Notification.NotificationsExtension", "increaseIconBadge", "(I)V", true);
            }
            var args = new Array<Dynamic>();
            args.push(number);
            increaseIconBadgeNumberBy(args);
		#end
    }
    
    public static function hxDecreaseIconBadgeNumberBy(number:Int = 0):Void
    {
		#if ios
        decreaseIconBadgeNumberBy(number);
		#end
		
		#if android
		if(decreaseIconBadgeNumberBy == null)
            {
                decreaseIconBadgeNumberBy = JNI.createStaticMethod("com.byrobin.Notification.NotificationsExtension", "decreaseIconBadge", "(I)V", true);
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
                cancelLocalNotifications = JNI.createStaticMethod("com.byrobin.Notification.NotificationsExtension", "cancelAllNotification", "()V", true);
            }
            var args = new Array<Dynamic>();
            cancelLocalNotifications();
		#end
    }
    
    public static function hxScheduleLocalNotification(message:String = "none", days:Int = 0, hours:Int = 0, minutes:Int = 0, seconds:Int = 0, repeat:Int = 0):Void
    {
        seconds = seconds + (minutes*60) + (hours*3600) + (days*86400);
		
		#if ios
        scheduleLocalNotification(message, seconds, repeat);
		#end
		
		#if android

            if(scheduleLocalNotification == null)
            {
                scheduleLocalNotification = JNI.createStaticMethod("com.byrobin.Notification.NotificationsExtension", "scheduleNotification", "(Ljava/lang/String;II)V", true);
            }
            var args = new Array<Dynamic>();
            args.push(message);
			args.push(seconds);
			args.push(repeat);
            scheduleLocalNotification(args);
        #end
    }
   
}
