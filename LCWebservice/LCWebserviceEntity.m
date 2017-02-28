//
//  LCWebserviceEntity.m
//  VMSMobile
//
//  Created by 刘超 on 16/4/25.
//  Copyright © 2016年 刘超. All rights reserved.
//

#import "LCWebserviceEntity.h"

@implementation LCWebserviceEntity
@synthesize delegate;

-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}

-(BOOL)getData{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetGroupInfo xmlns=\"cq-video.cn\">\n"
                             "<username>%@</username>\n"
                             "<userpassword>%@</userpassword>\n"
                             "</GetGroupInfo>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",@"gpsserver",@"carmanage"
                             ];
    NSLog(@"%@",soapMessage);
    
    //请求发送到的路径
    NSString *strUrl = [NSString stringWithFormat:@"%@/cms_service.asmx",@"http://124.164.240.151:7260"];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    NSString* strCommand = [NSString stringWithFormat:@"cq-video.cn/GetGroupInfo"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: strCommand forHTTPHeaderField:@"SOAPAction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self.delegate];
    
    //如果连接已经建好，则初始化data
    if( theConnection )
    {
        return YES;
    }
    else
    {
        NSLog(@"theConnection is NULL");
        return NO;
    }
    return YES;
}
@end
