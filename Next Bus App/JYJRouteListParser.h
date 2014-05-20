//
//  JYJRouteListParseDelegate.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import <Foundation/Foundation.h>
#import "JYJRoute.h"
#import "JYJDirection.h"
#import "JYJStop.h"

@interface JYJRouteListParser : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSXMLParser *parser;
@property (strong, nonatomic) NSMutableDictionary *routes;
@property (strong, nonatomic) NSMutableArray * routeTagsInOrder;

-(JYJRouteListParser *) initWithURL: (NSString *) url;
-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
-(void) parseRouteList;
-(NSArray *) returnRoutesAndTags;

@end
