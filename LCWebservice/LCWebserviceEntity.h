//
//  LCWebserviceEntity.h
//  VMSMobile
//
//  Created by 刘超 on 16/4/25.
//  Copyright © 2016年 刘超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCWebserviceEntity : NSObject{
    
    id delegate;
}
@property (nonatomic,retain)id       delegate;
-(BOOL)getData;
@end
