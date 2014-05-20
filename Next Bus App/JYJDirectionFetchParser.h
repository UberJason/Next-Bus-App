//
//  JYJDirectionFetchParser.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import <Foundation/Foundation.h>

@interface JYJDirectionFetchParser : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSXMLParser * parser;
@property (strong, nonatomic) NSMutableDictionary * stops;
@property (strong, nonatomic) NSMutableDictionary * directions;
-(JYJDirectionFetchParser *) initWithURL:(NSString *) url;
-(void) parseDirections;
-(NSArray *) returnStopsAndDirections;


@end
