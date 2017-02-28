//
//  LCWebserviceManager.h
//  VMSMobile
//
//  Created by 刘超 on 16/4/25.
//  Copyright © 2016年 刘超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCWebserviceEntity.h"
@interface LCWebserviceManager : NSObject
@property(nonatomic,retain)LCWebserviceEntity* currentWebservice;
+(LCWebserviceManager*)shareWebservice;
@end
