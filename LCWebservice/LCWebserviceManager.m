//
//  LCWebserviceManager.m
//  VMSMobile
//
//  Created by 刘超 on 16/4/25.
//  Copyright © 2016年 刘超. All rights reserved.
//

#import "LCWebserviceManager.h"

static LCWebserviceManager *webservicemgr = nil;

@implementation LCWebserviceManager
+(LCWebserviceManager*)shareWebservice{
    if (!webservicemgr) {
        webservicemgr = [[LCWebserviceManager alloc]init];
        webservicemgr.currentWebservice = [[LCWebserviceEntity alloc]init];
    }
    return webservicemgr;
}
@end
