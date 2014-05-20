//
//  JYJRouteListParseDelegate.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import "JYJRouteListParser.h"

@implementation JYJRouteListParser

-(JYJRouteListParser *) initWithURL:(NSString *) url {
    self = [super init];
    if(self) {
        _parser = [[NSXMLParser alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:url]];
        [_parser setDelegate:self];
    }
    
    _routes = [[NSMutableDictionary alloc] init];
    _routeTagsInOrder = [[NSMutableArray alloc] init];
    
    return self;
}

-(void) parseRouteList {
    [self.parser parse];
}

-(NSArray *) returnRoutesAndTags {
    return @[self.routes, self.routeTagsInOrder];
}

-(void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"route"]) {
        JYJRoute *route = [[JYJRoute alloc] init];
        route.tag = [attributeDict objectForKey:@"tag"];
        route.title = [attributeDict objectForKey:@"title"];
        [self.routes setObject:route forKey:route.tag];
        [self.routeTagsInOrder addObject:route.tag];
    }
   

}

-(void) parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
}

@end
