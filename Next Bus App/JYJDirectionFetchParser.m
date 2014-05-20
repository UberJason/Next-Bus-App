//
//  JYJDirectionFetchParser.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import "JYJDirectionFetchParser.h"
#import "JYJDirection.h"
#import "JYJStop.h"

#define DIRECTIONS_INIT_SIZE 2

@interface JYJDirectionFetchParser()

@property (nonatomic) BOOL reachedDirectionTag;
@property (strong, nonatomic) NSString * currentDirectionTag;

@end

@implementation JYJDirectionFetchParser

-(JYJDirectionFetchParser *) initWithURL:(NSString *)url {
    self = [super init];
    if(self) {
        _parser = [[NSXMLParser alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:url]];
        [_parser setDelegate:self];
    }
    _stops = [[NSMutableDictionary alloc] init];
    _directions = [[NSMutableDictionary alloc] init];
    _reachedDirectionTag = NO;
    return self;
}

-(void) parseDirections {
    [self.parser parse];
    
    NSLog(@"Here is the full list of stops:");
    [self.stops enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        //NSLog(@"Key: %@, Value: %@", [key description], [obj description]);
        NSLog(@"Key: %@", [key description]);
        JYJStop * myStop = (JYJStop *)obj;
        NSLog(@"Title: %@", myStop.title);
    }];
    NSLog(@"Here are the directions:");
    [self.directions enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"Direction: %@ contains the following stop IDs.", [key description]);
        NSMutableArray *stopList = [(JYJDirection *)obj stopTags];
        for(NSString * stop in stopList) {
            NSLog(@"%@", stop);
        }
    }];
}

-(NSArray *) returnStopsAndDirections {
    return @[self.stops, self.directions];
}

-(void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    
    
    if([elementName isEqualToString:@"stop"] && !self.reachedDirectionTag) {
        JYJStop *stop = [[JYJStop alloc] init];
        stop.tag = attributeDict[@"tag"];
        stop.title = attributeDict[@"title"];
        stop.lat = [NSNumber numberWithDouble: [attributeDict[@"lat"] doubleValue]];
        stop.lat = [NSNumber numberWithDouble: [attributeDict[@"lon"] doubleValue]];
        stop.stopId = [attributeDict objectForKey:@"stopId"];
        
        [self.stops setObject:stop forKey:stop.tag];
    }
    
    else if([elementName isEqualToString:@"stop"] && self.reachedDirectionTag) {
        JYJDirection *dir = self.directions[self.currentDirectionTag];
        [dir.stopTags addObject:attributeDict[@"tag"]];
        self.directions[self.currentDirectionTag] = dir;
        
    }
        
    else if([elementName isEqualToString:@"direction"]) {
        self.reachedDirectionTag = YES;
        self.currentDirectionTag = [attributeDict objectForKey:@"tag"];
        JYJDirection *direction = [[JYJDirection alloc] init];
        direction.tag = self.currentDirectionTag;
        direction.title = [attributeDict objectForKey:@"title"];
        direction.stopTags = [NSMutableArray array];
        
        [self.directions setObject:direction forKey:direction.tag];
    }
    
}

-(void) parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
}
@end
