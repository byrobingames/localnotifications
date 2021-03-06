# Stencyl Local Notification Extension (Openfl)

For Stencyl 3.4 and above

Stencyl extension for "Local Notification" on iOS and Android. This extension allows you to easily integrate Local Notification on your Stencyl game / application. (http://www.stencyl.com)

### Important!!

This Extension Required the Toolset Extension Manager [https://byrobingames.github.io](https://byrobingames.github.io)

![notificationtoolset](https://byrobingames.github.io/img/localnotification/notificationtoolset.png)

## Main Features

- works on IOS and android
- retpeat notification
- On Android badge number will only work on Samsung , HTC, Sony, Apex and  Solid.

## How to Install

To install this Engine Extension, go to the toolset (byRobin Extension Mananger) in the Extension menu of your game inside Stencyl.<br/>
![toolsetextensionlocation](https://byrobingames.github.io/img/toolset/toolsetextensionlocation.png)<br/>
Select the Extension from the menu and click on "Download"

If you not have byRobin Extension Mananger installed, install this first.<br/>
Go to: [https://byrobingames.github.io](https://byrobingames.github.io)

## Documentation and Block Examples

Create your notifications in the Toolset manager.<br/>
![localnotificationcreate](https://byrobingames.github.io/img/localnotification/localnotificationcreate.png)<br/>
**NotifId:** Give your notification an id. (Must be unique number between 0 and 63)<br/>
**Title:** Your notification Title<br/>
**Message:** Your notification Message<br/>
**Trigger after(in seconds):** Time when the system should trigger the notification after the Game is open for the first time.<br/>
**Repeat Every:** The interval at which to reschedule the notification.<br/>
Value can be set to no repeat, Minute, Hour, Day, Week or Year

<hr/>

**Schedule Local notifications** <br/>
![localnotificationschedule](https://byrobingames.github.io/img/localnotification/localnotificationschedule.png)<br/>

<hr/>

**Cancel notifications with NotifID** <br/>
![localnotificationcancelschedulenr](https://byrobingames.github.io/img/localnotification/localnotificationcancelschedulenr.png)<br/>

<hr/>

**Cancel all notifications** <br/>
![localnotificationcancelscheduleall](https://byrobingames.github.io/img/localnotification/localnotificationcancelscheduleall.png)<br/>

<hr/>

**Set icon badge number to** (deprecated in Android Version 8.0 > Will be set automatically when Notification is received)<br/>
![localnotificationsetbadge](https://byrobingames.github.io/img/localnotification/localnotificationsetbadge.png)<br/>

<hr/>

**Increase icon badge number by** (deprecated in Android Version 8.0 > Will be set automatically when Notification is received)<br/>
![localnotificationincreasebadge](https://byrobingames.github.io/img/localnotification/localnotificationincreasebadge.png)<br/>

<hr/>

**Decrease icon badge number by** (deprecated in Android Version 8.0 > Will be set automatically when Notification is received)<br/>
![localnotificationsetbadge](https://byrobingames.github.io/img/localnotification/localnotificationsetbadge.png)<br/>


## Version History

- 2.0 release 2015-07-23
- 2.1 2015-07-24 : BUG FIX On Android when game is force to closed by player, repeat notification does not work. Works only on background. and it works now on < iOS 8  (thanks mdotedot).
- 2.2 2015-07-26 : On Android when game is created first time Badge number wil set to 0. -  Add icon on blocks.
- 2.3 2015-07-31 : Now download via GitHub
- 2.4 2015-08-05 : Comments the assets path in include.xml, assets folder is not needed.
- 2.5 2015-10-09 : Android Updated android-support-v4.jar to get it work with Stencyl build b9186 and higher
- 2.5.1(2017-05-16) Tested for Stencyl 3.5, Required byRobin Toolset Extension Manager
- 2.5.2(2017-05-18): FIX: iOS when selelect no repeat, notification not showing. FIX: single/double quotes does not accepted.
- 2.5.3(2018-12-30): Fix Android JNI import; Fix when set Android TargetVersion 26.; Set/Increase/Decrease icon badge number is deprecated in Android Version 8 >

## Submitting a Pull Request

This software is opensource.<br/>
If you want to contribute you can make a pull request

Repository: [https://github.com/byrobingames/localnotifications](https://github.com/byrobingames/localnotifications)

Need help with a pull request?<br/>
[https://help.github.com/articles/creating-a-pull-request/](https://help.github.com/articles/creating-a-pull-request/)

## ANY ISSUES?

Add the issue on GitHub<br/>
Repository: [https://github.com/byrobingames/localnotifications/issues](https://github.com/byrobingames/localnotifications/issues)

Need help with creating a issue?<br/>
[https://help.github.com/articles/creating-an-issue/](https://help.github.com/articles/creating-an-issue/)

## Donate

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HKLGFCAGKBMFL)<br />

## License

Author: Robin Schaafsma

The MIT License (MIT)

Copyright (c) 2014 byRobinGames [http://www.byrobin.nl](http://www.byrobin.nl)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
