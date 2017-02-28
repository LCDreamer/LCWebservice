//
//  LCNSXMLParser.m
//  VMSMobile
//
//  Created by 刘超 on 16/4/25.
//  Copyright © 2016年 刘超. All rights reserved.
//

#import "LCNSXMLParser.h"

@implementation LCNSXMLParser
@synthesize result;
@synthesize aElementName;
@synthesize recvData;
@synthesize xmlParse;

-(id)init{
    if (self=[super init]) {

    }
    return self;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (self.recvData == nil) {
        self.recvData = [NSMutableData data] ;
    }
    [recvData setLength:0];
    NSLog(@"1");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    recordResults = NO;
    [recvData appendData:data];
    NSLog(@"2");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"3-recv len = %d",[recvData length]);
    NSString *theXML = [[NSString alloc] initWithBytes: [recvData mutableBytes] length:[recvData length] encoding:NSUTF8StringEncoding];
    
    xmlParse = [[NSXMLParser alloc] initWithData: recvData];
    [xmlParse setDelegate:self];
    [xmlParse setShouldResolveExternalEntities: YES];
    [xmlParse parse];
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"4");
    if ([elementName isEqualToString:aElementName]) {
        if (!result) {
            result=[[NSMutableString alloc]init];
        }
        recordResults =YES;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"5");
    if (recordResults) {
        [result appendString:string];
    }
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"6");
 
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

@end
