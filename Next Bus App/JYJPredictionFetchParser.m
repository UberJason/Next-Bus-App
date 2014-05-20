//
//  JYJPredictionFetchParser.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/6/13.
//
//

#import "JYJPredictionFetchParser.h"

#define AGENCY_TITLE @"agencyTitle"
#define ROUTE_TITLE @"routeTitle"
#define STOP_TITLE @"stopTitle"
#define STOP_TAG @"stopTag"

@interface JYJPredictionFetchParser()

@end

@implementation JYJPredictionFetchParser

NSString * currentDirection = @"";

-(JYJPredictionFetchParser *)initWithURL:(NSString *) url {
    self = [super init];
    if(self) {
        _parser = [[NSXMLParser alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:url]];
        _parser.delegate = self;
    }
    
    _numberOfDirections = 0;
    _predictions = [NSMutableArray array];
    _messages = [NSMutableArray array];
    _predictionConfigs = [NSMutableDictionary new];
    return self;
    
}

-(BOOL) parsePredictions {
    BOOL success = YES;
    
    if([self.parser parse]) {
        NSLog(@"Here are all the predictions:");
        for(JYJPrediction * prediction in self.predictions) {
            NSLog(@"%@\t%@ min \t\t %@ refresh seconds", prediction.dirTag, prediction.minutes, prediction.seconds);
        }
    }
    else {
//        NSLog(@"Error occurred while parsing: %@ - %@ - %@", [self.parser.parserError localizedDescription], [[self.parser.parserError userInfo].allKeys[0] description], [[self.parser.parserError userInfo][[self.parser.parserError userInfo].allKeys[0]] description]);
        NSLog(@"Error occurred while parsing: %@", [self.parser.parserError localizedDescription]);
        success = NO;
    }

    return success;
}

-(NSArray *) returnPredictionData {
    return @[self.predictions, @(self.numberOfDirections), self.messages, self.predictionConfigs];
}

-(void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    
    //    NSLog(@"In parser delegate method. elementName=%@", elementName);
    
    if([elementName isEqualToString:@"predictions"]) {
        self.predictionConfigs = [[NSMutableDictionary alloc] init];
        self.predictionConfigs[AGENCY_TITLE] = attributeDict[AGENCY_TITLE];
        self.predictionConfigs[ROUTE_TITLE] = attributeDict[ROUTE_TITLE];
        self.predictionConfigs[STOP_TITLE] = attributeDict[STOP_TITLE];
        self.predictionConfigs[STOP_TAG] = attributeDict[STOP_TAG];
        
        NSLog(@"agency title:%@", attributeDict[AGENCY_TITLE]);
    }
    
    else if([elementName isEqualToString:@"direction"]) {
        currentDirection = attributeDict[@"title"];
        self.numberOfDirections++;
    }
    
    else if([elementName isEqualToString:@"prediction"]) {
        JYJPrediction *prediction = [[JYJPrediction alloc] init];
        prediction.epochTime = attributeDict[@"epochTime"];
        prediction.seconds = attributeDict[@"seconds"];
        prediction.minutes = attributeDict[@"minutes"];
        prediction.isDeparture = ([attributeDict[@"isDeparture"] isEqualToString:@"false"] ? NO : YES);
        prediction.affectedByLayover = ([attributeDict[@"affectedByLayover"] isEqualToString:@"false"] ? NO : YES);
        prediction.dirTag = attributeDict[@"dirTag"];
        prediction.dirString = currentDirection;
        prediction.vehicle = attributeDict[@"vehicle"];
        prediction.block = attributeDict[@"block"];
        prediction.tripTag = attributeDict[@"tripTag"];
        
        //        NSLog(@"About to add prediction: %@", [prediction description]);
        
        [self.predictions addObject:prediction];
    }
    
    else if([elementName isEqualToString:@"message"]) {
        //        NSLog(@"The message is %@", attributeDict[@"text"]);
        [self.messages addObject: attributeDict[@"text"]];
    }
    
    //    NSLog(@"Haven't crashed yet!");
    
}

@end
