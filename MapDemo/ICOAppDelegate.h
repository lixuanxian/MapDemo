//
//  ICOAppDelegate.h
//  MapDemo
//
//  Created by Sean on 3/1/13.
//  Copyright (c) 2013 ICOCHINA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface ICOAppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;

@end
