//
//  ViewController.m
//  Local Notification
//
//  Created by Simone Conia on 15/11/13.
//  Copyright (c) 2013 Simone Conia. All rights reserved.
//
//  Modified by robinschaafsma
//  - updated for IOS 8
//  - deleted showAlert (by default in stencyl)
//  - play default sound when notification calls.
//

#import "Notifications.h"
#import <UIKit/UIKit.h>

using namespace notifications;

extern "C" void nme_app_set_active(bool inActive);

@interface NotificationController: NSObject
{

}

@end

@interface NMEAppDelegate : NSObject <UIApplicationDelegate>
@end

@implementation NMEAppDelegate (NotificationController)

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    nme_app_set_active(true);
    
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

@end

@implementation NotificationController


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
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void) scheduleLocalNotificationWithBody:(NSString*)body withTimeIntervalSinceNow:(int)timeInterval withRepeatTime:(int)repeatTime
{

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        
    }
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    notification.timeZone = [NSTimeZone defaultTimeZone];
        
        
       /* NSYearCalendarUnit = event will repeat once in a year at the same month, day and hour
        NSMonthCalendarUnit = event will repeat once a month at the same day and hour
        NSDayCalendarUnit = event will repeat every day at the same hour
        NSHourCalendarUnit = event will repeat every hour at the same minute
        NSMinuteCalendarUnit = event will repeat every minute at the same second
        NSSecondCalendarUnit = event will repeat every second
        NSWeekCalendarUnit = event will repeat the same day of week every week
        NSWeekdayCalendarUnit = ?????? can I make it repeat just specific days? I mean, monday to friday but not saturday and sunday?
        NSWeekdayOrdinalCalendarUnit = ????? how do I use that?
        NSQuarterCalendarUnit = when exactly will it repeat? every 3 months?*/
        
        if (repeatTime == 1)
        {
            notification.repeatInterval = NSMinuteCalendarUnit;
        }else if (repeatTime == 2)
        {
            notification.repeatInterval = NSHourCalendarUnit;
        }else if (repeatTime == 3)
        {
            notification.repeatInterval = NSDayCalendarUnit;
        }else if (repeatTime == 4)
        {
            notification.repeatInterval = NSWeekCalendarUnit;
        }else if (repeatTime == 5)
        {
            notification.repeatInterval = NSMonthCalendarUnit;
        }else if (repeatTime == 6)
        {
            notification.repeatInterval = NSQuarterCalendarUnit;
        }else if (repeatTime == 7)
        {
            notification.repeatInterval = NSYearCalendarUnit;
        }else
        {
            notification.repeatInterval = nil;
        }
    

    notification.alertBody = body;

    NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badgeNumber += 1;
    notification.applicationIconBadgeNumber = badgeNumber;

    notification.soundName = UILocalNotificationDefaultSoundName;
    
    // this will schedule the notification to fire at the fire date
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

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
    
    void scheduleLocalN(const char* message, int time, int repeat)
    {
        if(notificationController == NULL)
        {
            NotificationController* nc = [[NotificationController alloc] init];
            notificationController = nc;
        }
        NSString* newMessage = [[NSString alloc] initWithUTF8String: message];
        [notificationController scheduleLocalNotificationWithBody:newMessage withTimeIntervalSinceNow:time withRepeatTime:repeat];
    }
    
}

@end
