//
//  JRFBNavigationViewController.m
//  iOSFileBroswer
//
//  Created by J on 2016/11/15.
//  Copyright © 2016年 J. All rights reserved.
//

#import "JRFBNavigationViewController.h"
#import "JRFBViewController.h"

@interface JRFBNavigationViewController ()

@end

@implementation JRFBNavigationViewController

+ (instancetype)controller {
    JRFBViewController *vc = [[JRFBViewController alloc] initWithPath:nil];
    JRFBNavigationViewController *nav = [[JRFBNavigationViewController alloc] initWithRootViewController:vc];
    return nav;
}

@end
