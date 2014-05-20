//
//  JYJPredictionFetchParser.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/6/13.
//
//

#import <Foundation/Foundation.h>
#import "JYJPrediction.h"

@interface JYJPredictionFetchParser : NSObject <NSXMLParserDelegate>
@property (strong, nonatomic) NSXMLParser * parser;
-(JYJPredictionFetchParser *) initWithURL:(NSString *) url;

@property (strong, nonatomic) NSMutableDictionary *predictionConfigs;    // a dictionary of details about this set of predictions (agency, routeTag, stopTitle)
@property (strong, nonatomic) NSMutableArray * predictions; // an array of prediction objects in order of time (order is determined by the XML feed)
@property (nonatomic) int numberOfDirections;
@property (strong, nonatomic) NSMutableArray * messages;   // an NSArray of NSStrings of messages, if any.

-(BOOL) parsePredictions;           // return YES if successful, NO otherwise
-(NSArray *) returnPredictionData;
@end
