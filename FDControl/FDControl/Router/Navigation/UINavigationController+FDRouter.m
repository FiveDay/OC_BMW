//
//  UINavigationController+FDRouter.m
//  FDControl
//
//  Created by zhangyu528 on 2019/4/16.
//  Copyright © 2019 zhangyu528. All rights reserved.
//

#import "UINavigationController+FDRouter.h"
#import "FDRouter.h"

@implementation UINavigationController (FDRouter)

+ (void)registerRoutes:(NSSet<FDNavigationRouterRegParam*>*)routes {
    [[FDRouter shared]registerRoutes:routes];
}

- (void)navTo:(NSString*)path {
//    [[FDRouter shared]navTo:path handle:^(Class  _Nullable __unsafe_unretained component, NSDictionary * _Nullable params) {
//        UIViewController* viewCtl = [component viewControllerWithParam:params];
//        [self pushViewController:viewCtl animated:YES];
//    }];
    UIViewController* viewCtl = [[FDRouter shared]navTo:path];
    [self pushViewController:viewCtl animated:YES];
}

- (void)navToUrl:(NSURL*)url {
//    [[FDRouter shared]navToUrl:url handle:^(Class  _Nullable __unsafe_unretained component, NSDictionary * _Nullable params) {
//        UIViewController* viewCtl = [component viewControllerWithParam:params];
//        [self pushViewController:viewCtl animated:YES];
//    }];
    UIViewController* viewCtl = [[FDRouter shared]navToUrl:url];
    [self pushViewController:viewCtl animated:YES];
}

- (void)navToName:(NSString*)name param:(NSDictionary*)param {
    UIViewController* viewCtl = [[FDRouter shared]navToName:name param:param];
    [self pushViewController:viewCtl animated:YES];
}
@end
