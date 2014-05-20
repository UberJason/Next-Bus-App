//
//  JYJPredictionFetchModel.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/6/13.
//
//

#import "JYJPredictionFetchModel.h"

#define AGENCY_TITLE @"agencyTitle"
#define ROUTE_TITLE @"routeTitle"
#define STOP_TITLE @"stopTitle"
#define STOP_TAG @"stopTag"

@interface JYJPredictionFetchModel()


@end

@implementation JYJPredictionFetchModel

-(JYJPredictionFetchModel *) initWithRoute:(JYJRoute *)route
                                 direction:(JYJDirection *)direction
                                      stop:(JYJStop *)stop
                                    agency:(NSString *) agency {
    
    self = [super init];
    if(self) {
        _route = route;
        _direction = direction;
        _stop = stop;
        _agency = agency;
        
        _routeTag = _route.tag;
        _directionTag = _direction.tag;
        _stopTag = _stop.tag;

    }
    return self;
    
}

-(JYJPredictionFetchModel *) initWithRouteTag:(NSString *)routeTag
                                      stopTag:(NSString *)stopTag
                                       agency:(NSString *)agency {
    
    self = [super init];
    if(self) {
        _routeTag = routeTag;
        _stopTag = stopTag;
        _agency = agency;
        
        _route = [[JYJRoute alloc] init];
        _route.tag = routeTag;
        _stop = [[JYJStop alloc] init];
        _stop.tag = stopTag;
    
    }
    return self;
    
}

-(BOOL) parsePredictions {
    
    NSString * routeURLBase = @"http://webservices.nextbus.com/service/publicXMLFeed?command=predictions";
    
    NSArray *urlPieces = @[routeURLBase, @"&a=", self.agency, @"&r=", self.routeTag, @"&s=", self.stopTag];
    
    self.routeURL = [urlPieces componentsJoinedByString:@""];
    
    NSLog(@"routeURL = %@", self.routeURL);
    
    JYJPredictionFetchParser *parser = [[JYJPredictionFetchParser alloc] initWithURL: self.routeURL];
    
    BOOL success = [parser parsePredictions];
    if(success) {
        NSArray * temp = [parser returnPredictionData];
        
        self.predictions = temp[0];
        self.numberOfDirections = [temp[1] intValue];
        self.messages = temp[2];
        NSDictionary *predictionConfigs = temp[3];
        
        self.agencyTitle = predictionConfigs[AGENCY_TITLE];
        self.route.title = predictionConfigs[ROUTE_TITLE];
        self.stop.title = predictionConfigs[STOP_TITLE];
        self.stop.tag = predictionConfigs[STOP_TAG];
    }
    
    return success;
}

-(NSTimeInterval)shortestRefreshInterval {
    if([self.predictions count] == 0)
        return 60.0;
    
    JYJPrediction *prediction = self.predictions[0];
    double shortestRefreshInterval = [prediction.seconds doubleValue];
    
    for(JYJPrediction *prediction in self.predictions) {
        double refreshInterval = [prediction.seconds doubleValue];
        if(refreshInterval < shortestRefreshInterval)
            shortestRefreshInterval = refreshInterval;
    }
    
    NSLog(@"shortest refresh interval: %f", shortestRefreshInterval);
    return shortestRefreshInterval;
}

@end

