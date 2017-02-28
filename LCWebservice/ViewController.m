//
//  ViewController.m
//  LCWebservice
//
//  Created by 刘超 on 16/4/25.
//  Copyright © 2016年 刘超. All rights reserved.
//

#import "ViewController.h"
#import "LCNSXMLParser.h"
#import "LCWebserviceManager.h"
@interface ViewController ()
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSURLConnection *conn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//     [self downloadData];
    //封装soap请求消息
    [self getDoService];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)getDataForSession{
    
    //请求发送到的路径
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<Login xmlns=\"cq-video.cn\">\n"
                             "<_userName>%@</_userName>\n"
                             "<_newPassword>%@</_newPassword>\n"
                             "</Login>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",@"gpsserver",@"carmanage"
                             ];
    
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/cms_service.asmx",@"http://124.164.240.151:7260"];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    [theRequest setTimeoutInterval:10];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    NSString* strCommand = [NSString stringWithFormat:@"cq-video.cn/GetGroupInfo"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: strCommand forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    
    
    // 创建Data Task
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:theRequest
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          
                                      }];
    [dataTask resume];

    
}

-(void)downloadData{
    LCNSXMLParser*carInfo=[[LCNSXMLParser alloc]init];
    [LCWebserviceManager shareWebservice].currentWebservice.delegate=carInfo;
    [[LCWebserviceManager shareWebservice].currentWebservice getData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)query:(NSString*)phoneNumber{
    
    // 创建SOAP消息，内容格式就是网站上提示的请求报文的主体实体部分    这里使用了SOAP1.2；
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                         "<soap12:Envelope "
                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                         "<soap12:Body>"
                         "<getMobileCodeInfo xmlns=\"http://WebXml.com.cn/\">"
                         "<mobileCode>%@</mobileCode>"
                         "<userID>%@</userID>"
                         "</getMobileCodeInfo>"
                         "</soap12:Body>"
                         "</soap12:Envelope>", phoneNumber, @""];
    
    NSURL *url = [NSURL URLWithString: @"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMsg length]];
    [req addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (self.conn) {
        self.webData = [NSMutableData data];
    }
    
}
-(BOOL)getDoService{
    NSString * soapMessage  =@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
    "<soap:Body>\n"
    "<doService xmlns=\"http://www.sdhrss.gov.cn/webWebservice/services/PublicServiceIOS\">\n"
    "<flag>0000001</flag>\n"
    "</soap:Body>\n"
    "</soap:Envelope>\n";
    
    //请求发送到的路径
    NSString *strUrl = [NSString stringWithFormat:@"http://www.sdhrss.gov.cn/webWebservice/services/PublicServiceIOS"];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    [theRequest setTimeoutInterval:10];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    //    NSString* strCommand = [NSString stringWithFormat:@"http://www.sdhrss.gov.cn/webWebservice/services/PublicServiceIOS/doService"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    [theRequest addValue: strCommand forHTTPHeaderField:@"SOAPAction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
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

-(BOOL)getGroupInfo
{
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
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
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


// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [self.webData setLength: 0];
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    
    if(data != NULL){
        [self.webData appendData:data];
    }
    
}

// 出现错误时
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    self.conn = nil;
    self.webData = nil;
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSString *theXML = [[NSString alloc] initWithBytes:[self.webData mutableBytes]
                                                length:[self.webData length]
                                              encoding:NSUTF8StringEncoding];
    
    // 打印出得到的XML  
    NSLog(@"返回的数据：%@", theXML);  
    
}

@end
