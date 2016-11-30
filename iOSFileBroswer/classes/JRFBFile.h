//
//  JRFBFile.h
//  iOSFileBroswer
//
//  Created by J on 2016/11/15.
//  Copyright © 2016年 J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRFBFile : NSObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL isDirectory;

@end
