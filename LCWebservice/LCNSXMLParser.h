//
//  LCNSXMLParser.h
//  VMSMobile
//
//  Created by 刘超 on 16/4/25.
//  Copyright © 2016年 刘超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCNSXMLParser : NSObject<NSXMLParserDelegate>{
    NSMutableString*result;
    NSString*aElementName;
    NSMutableData *recvData;
    BOOL recordResults;
    NSXMLParser *xmlParse;
}
@property(nonatomic,retain)NSMutableString*result;
@property(nonatomic,retain)NSString*aElementName;
@property(nonatomic,retain)NSMutableData *recvData;
@property (nonatomic,retain)NSXMLParser *xmlParse;
@end
