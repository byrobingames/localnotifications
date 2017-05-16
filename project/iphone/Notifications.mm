//
//  ViewController.m
//
//  by robinschaafsma
//  - updated for IOS 10
//

#import "Notifications.h"
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

using namespace notifications;
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//extern "C" void nme_app_set_active(bool inActive);

@interface NotificationController : NSObject <UIApplicationDelegate>
{

}

@end

//@interface NMEAppDelegate : NSObject <UIApplicationDelegate>
//@end

/*@implementation NMEAppDelegate (NotificationController)

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //nme_app_set_active(true);
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    application.applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    //UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification Received" message:notification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[alertView show];
    
    application.applicationIconBadgeNumber = 0;
    
}

@end*/

@implementation NotificationController
    
- (void)requestNotificationPermissions
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")){
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge + UNAuthorizationOptionCarPlay;
        
        [center requestAuthorizationWithOptions:options
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!granted) {
                                      NSLog(@"Error: %@",[error localizedDescription]);
                                  }else {
                                      NSLog(@"Access Granted ");
                                      
                                  }
                              }];
        
    }else if(SYSTEM_VERSION_LESS_THAN(@"10.0") && SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    }
}

- (void) setIconBadgeNumber:(int)badgeNumber
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
}

- (void) increaseIconBadgeNumberBy:(int)increaseNumber
{
    NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badgeNumber += increaseNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
}

- (void) decreaseIconBadgeNumberBy:(int)decreaseNumber
{
    NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badgeNumber -= decreaseNumber;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
}

- (void) cancelLocalNotifications
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")){
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
        [center removeAllDeliveredNotifications];
    }else{
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}
- (void) cancelLocalNotificationsWithID:(NSString*)notifid
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")){
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center removePendingNotificationRequestsWithIdentifiers:@[notifid]];
        [center removeDeliveredNotificationsWithIdentifiers:@[notifid]];
    }else{
        NSArray* pendingNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
        if (pendingNotifications.count == 0)
        {
            return;
        }
    
        for (UILocalNotification* notification in pendingNotifications)
        {
            NSDictionary* userInfo = notification.userInfo;
        
            if([[userInfo objectForKey:@"NotifId"] isEqualToString:notifid])
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
            }
        }
    }
}

- (void) scheduleIOS8LocalNotificationWithID:(int)notifid WithBody:(NSString*)message withTitle:(NSString*)title withTimeIntervalSinceNow:(int)timeInterval withRepeatTime:(NSString*)repeat
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
        
        if ([repeat isEqualToString:@"Minute"])
        {
            notification.repeatInterval = NSCalendarUnitMinute;
        }else if ([repeat isEqualToString:@"Hour"])
        {
            notification.repeatInterval = NSCalendarUnitHour;
        }else if ([repeat isEqualToString:@"Day"])
        {
            notification.repeatInterval = NSCalendarUnitDay;
        }else if ([repeat isEqualToString:@"Week"])
        {
            notification.repeatInterval = NSCalendarUnitWeekOfYear;
        }else if ([repeat isEqualToString:@"Month"])
        {
            notification.repeatInterval = NSCalendarUnitMonth;
        }else if ([repeat isEqualToString:@"Year"])
        {
            notification.repeatInterval = NSCalendarUnitYear;
        }else
        {
            notification.repeatInterval = nil;
        }
    
    if ([notification respondsToSelector:@selector(alertTitle)]) // iOS 8.2 and above
    {
        if([title length] != 0)
        {
            notification.alertTitle = title;
        }
    }
    notification.alertBody = message;

    NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badgeNumber ++;
    notification.applicationIconBadgeNumber = badgeNumber;

    notification.soundName = UILocalNotificationDefaultSoundName;
    
    NSString *identifier = [NSString stringWithFormat:@"%d", notifid];
    NSDictionary* userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:identifier, @"NotifId", nil];
    notification.userInfo = userInfo;
    
    // this will schedule the notification to fire at the fire date
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

}
- (void)scheduleIOS10LocalNotificationWithID:(int)notifid WithBody:(NSString*)message withTitle:(NSString*)title withTimeIntervalSinceNow:(int)timeInterval withRepeatTime:(NSString*)repeat
{
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:message arguments:nil];
        content.sound = [UNNotificationSound defaultSound];
        
        
        NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
        badgeNumber += 1;
        content.badge = [NSNumber numberWithInteger:badgeNumber];
    
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [calendar setTimeZone:[NSTimeZone localTimeZone]];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
        NSDateComponents *triggerDate;
        
        if ([repeat isEqualToString:@"Minute"])
        {
            triggerDate = [calendar
                           components:NSCalendarUnitSecond + NSTimeZoneCalendarUnit
                           fromDate:date];
        }else if ([repeat isEqualToString:@"Hour"])
        {
            triggerDate = [calendar
                           components:NSCalendarUnitSecond + NSCalendarUnitMinute + NSTimeZoneCalendarUnit
                           fromDate:date];
        }else if ([repeat isEqualToString:@"Day"])
        {
            triggerDate = [calendar
                           components:NSCalendarUnitHour + NSCalendarUnitMinute + NSCalendarUnitSecond + NSTimeZoneCalendarUnit
                           fromDate:date];
        }else if ([repeat isEqualToString:@"Week"])
        {
            triggerDate = [calendar
                           components:NSCalendarUnitHour + NSCalendarUnitMinute + NSCalendarUnitSecond + NSCalendarUnitWeekday + NSTimeZoneCalendarUnit
                           fromDate:date];
        }else if ([repeat isEqualToString:@"Month"])
        {
            triggerDate = [calendar
                           components:NSCalendarUnitHour + NSCalendarUnitMinute + NSCalendarUnitSecond + NSCalendarUnitDay + NSTimeZoneCalendarUnit
                           fromDate:date];
        }else if ([repeat isEqualToString:@"Year"])
        {
            triggerDate = [calendar
                           components:NSCalendarUnitHour + NSCalendarUnitMinute + NSCalendarUnitSecond + NSCalendarUnitDay + NSCalendarUnitMonth + NSTimeZoneCalendarUnit
                           fromDate:date];
        }else
        {
            triggerDate = [calendar
                           components:nil
                           fromDate:date];
        }
    
        
        UNCalendarNotificationTrigger *trigger;
        
        if ([repeat isEqualToString:@"no repeat"]){
            trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];

        }else{
            trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:YES];
        }
    
        NSString *identifier = [NSString stringWithFormat:@"%d", notifid];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                              content:content trigger:trigger];
    
    
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"Something went wrong: %@",error);
            }
        }];
}

namespace notifications
{
    static NotificationController* notificationController;
    
    void setIconBadgeN(int number)
    {
        if(notificationController == NULL)
        {
            NotificationController* nc = [[NotificationController alloc] init];
            notificationController = nc;
        }
        [notificationController setIconBadgeNumber:number];
    }
    
    void increaseIconBadgeN(int number)
    {
        if(notificationController == NULL)
        {
            NotificationController* nc = [[NotificationController alloc] init];
            notificationController = nc;
        }
        [notificationController increaseIconBadgeNumberBy:number];
    }
    
    void decreaseIconBadgeN(int number)
    {
        if(notificationController == NULL)
        {
            NotificationController* nc = [[NotificationController alloc] init];
            notificationController = nc;
        }
        [notificationController decreaseIconBadgeNumberBy:number];
    }
    
    void cancelLocalN()
    {
        if(notificationController == NULL)
        {
            NotificationController* nc = [[NotificationController alloc] init];
            notificationController = nc;
        }
        [notificationController cancelLocalNotifications];
    }
    
    void cancelLocalNWithID(int notifid)
    {
        if(notificationController == NULL)
        {
            NotificationController* nc = [[NotificationController alloc] init];
            notificationController = nc;
        }
        NSString* newnotifid = [NSString stringWithFormat:@"%d", notifid];;
        
        [notificationController cancelLocalNotificationsWithID:newnotifid];
    }
    
    void scheduleLocalN(const char* jsonString)
    {
        if(notificationController == NULL)
        {
            NotificationController* nc = [[NotificationController alloc] init];
            notificationController = nc;
            //[notificationController requestNotificationPermissions];
        }
        
        [notificationController requestNotificationPermissions];
        
        NSString* newjsonString = [[NSString alloc] initWithUTF8String: jsonString];
        
        NSData *jsonData = [newjsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        
        NSArray* jsonArray = [[NSMutableArray alloc] init];
        jsonArray = [NSJSONSerialization JSONObjectWithData: jsonData options:NSJSONReadingMutableContainers error:&error];
        for(NSArray* notifArray in jsonArray)
        {
            NSLog(@"NSArray %@", notifArray);
            
            int notifid = [[notifArray objectAtIndex:0] intValue];
            NSString* title = [notifArray objectAtIndex:1];
            NSString* message = [notifArray objectAtIndex:2];
            int timeinterval = [[notifArray objectAtIndex:3] intValue];
            NSString* repeat = [notifArray objectAtIndex:4];
            
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")){
                [notificationController scheduleIOS10LocalNotificationWithID:notifid WithBody:message withTitle:title withTimeIntervalSinceNow:timeinterval withRepeatTime:repeat];
            }else{
                [notificationController scheduleIOS8LocalNotificationWithID:notifid WithBody:message withTitle:title withTimeIntervalSinceNow:timeinterval withRepeatTime:repeat];
            }
            
        }
    }
    
}

@end
