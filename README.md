## StencylSimple Share via e-mail, Twitter, Facebook etc. Extension (Openfl)

For Stencyl 3.3 and above

Stencyl extension for "Simple Share" on iOS and Android. This extension allows you to easily integrate Simple Share via e-mail, Twitter, Facebook etc. on your Stencyl game / application. (http://www.stencyl.com)

You can share a message with a website and take a screenshot, via all existing apps on a mobile device. This extension use the IMAGE API to take a screenshot.

###The website or screenshot will share with Facebook and not the message. All other apps works fine..
It seems that a recent update to the Facebook application has replaced the in-built Facebook share activity with one that ignores status text .

Facebook's policies don't allow you to pre-populate status messages and require all content to be user generated - while I understand the intention behind this, I personally think it is kind of stupid in many cases - For example in my game I want to pre-populate the user's score, but now I can't, so the user is presented with an empty dialog box. I will probably simply remove the Facebook sharing option as no-one will ever use it now.<br/>
https://developers.facebook.com/docs/apps/review/prefill

## Main Features

- Simple share with 1 button click.
- Share Screenshot on IOS and Android
- Return true or false (android always return true)
- 64-bit support to iOS
- Tested with iPhone 5 IOS 8, Ipad IOS 8 and Samgsung Note 3 4.4.2

## Screenshots
![iosscreenshot](http://www.byrobingames.com/stencyl/simpleshare/simpleshareios.png)![androidscreenshot](http://www.byrobingames.com/stencyl/simpleshare/simpleshareandroid.png)

## How to Install
Download zip file on the right of the screen. ![download](http://www.byrobingames.com/stencyl/heyzap/download.png) on this page https://github.com/byrobingames/simpleshare<br />

Install the zip file: Go to : http://community.stencyl.com/index.php/topic,30432.0.html

If you have already install a previous version (1.7 or lower) of Simple Share extension, you will see two extension in "Settings->Extensions". This is because of the renamed folder you just downloaded from GitHub.
If this is your case, do the following:
- Go to Settings->Extensions
- Enable the Simple Share Extension thats not enabled (press green button "Enable")
- Disable the Simple Share Extension thats not disabled (press red button "Disable")
- Close your Game
- Go to "YOURDOCUMENTFOLDER/stencylworks/engine-extensions/" folder
- Delete the folder "simpleshare" and leave the folder "simpleshare-master"(thats the new folder name)
- Open you Game
- You see can in Settings->Extensions, there is now jus one Simple Share extension.
- The blocks you already used with previous version subsist.

Or for advanced users:(Not recommended)
- Unzip simpleshare-master.zip you just download
- Rename folder from "simpleshare-master" to "simpleshare"
- Copy the simpleshare folder and paste it in "YOURDOCUMENTFOLDER/stencylworks/engine-extensions/"
- You have to do this every time you download a updated version fom GitHub.

## Documentation and Blocks Example

Just put the block under a share button, fill in a message with a website url and set yes or no if you wanna share a screenshot. Website has to start with http://
Select yes or no if you wanna share a screenshot.

//TODO

## Donate

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HKLGFCAGKBMFL)<br />

## License

The MIT License (MIT) - LICENSE.md

Copyright © 2014 byRobinGames (http://www.byrobingames.com)

Author: Robin Schaafsma
