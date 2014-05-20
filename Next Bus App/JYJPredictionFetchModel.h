//
//  JYJPredictionFetchModel.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/6/13.
//
//

#import <Foundation/Foundation.h>
#import "JYJPredictionFetchParser.h"
#import "JYJRoute.h"
#import "JYJDirection.h"
#import "JYJStop.h"

@interface JYJPredictionFetchModel : NSObject

@property (strong, nonatomic) JYJRoute *route;
@property (strong, nonatomic) JYJDirection *direction;
@property (strong, nonatomic) JYJStop *stop;
@property (strong, nonatomic) NSString *agency;
@property (strong, nonatomic) NSString *agencyTitle;

@property (strong, nonatomic) NSString *routeTag;
@property (strong, nonatomic) NSString *directionTag;
@property (strong, nonatomic) NSString *stopTag;

@property (strong, nonatomic) NSMutableArray * predictions; //Array of prediction objects
@property (nonatomic) int numberOfDirections;
@property (strong, nonatomic) NSMutableArray * messages;

@property (strong, nonatomic) NSString * routeURL;

-(JYJPredictionFetchModel *) initWithRoute: (JYJRoute *) route
                                 direction: (JYJDirection *) direction
                                      stop: (JYJStop *) stop
                                    agency: (NSString *) agency;

-(JYJPredictionFetchModel *) initWithRouteTag:(NSString *)routeTag
                                      stopTag:(NSString *)stopTag
                                       agency:(NSString *) agency;

-(BOOL) parsePredictions;
-(NSTimeInterval)shortestRefreshInterval;

@end
