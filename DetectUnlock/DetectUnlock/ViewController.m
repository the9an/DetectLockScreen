//
//  ViewController.m
//  DetectUnlock
//
//  Created by NguyenTheQuan on 2014/07/14.
//  Copyright (c) 2014年 Home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self registerforDeviceLockNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//call back
static void displayStatusChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    // the "com.apple.springboard.lockcomplete" notification will always come after the "com.apple.springboard.lockstate" notification
    
    NSString *lockState = (__bridge NSString*)name;
    NSLog(@"Darwin notification NAME = %@",name);
    
    if([lockState isEqualToString:@"com.apple.springboard.lockcomplete"])
    {
        NSLog(@"DEVICE LOCKED");
    }
    else
    {
        NSLog(@"LOCK STATUS CHANGED");
    }
}


-(void)registerforDeviceLockNotification
{
    //Screen lock notifications
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), //center
                                    NULL, // observer
                                    displayStatusChanged, // callback
                                    CFSTR("com.apple.springboard.lockcomplete"), // event name
                                    NULL, // object
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), //center
                                    NULL, // observer
                                    displayStatusChanged, // callback
                                    CFSTR("com.apple.springboard.lockstate"), // event name
                                    NULL, // object
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
}

@end
