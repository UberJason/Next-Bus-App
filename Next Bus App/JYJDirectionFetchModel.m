//
//  JYJDirectionFetchModel.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import "JYJDirectionFetchModel.h"

@interface JYJDirectionFetchModel ()

@property (strong, nonatomic) NSString * routeURL;

@end

@implementation JYJDirectionFetchModel

-(JYJDirectionFetchModel *) initWithRoute:(JYJRoute *)route
                                   agency: (NSString *) agency {
    
    self = [super init];
    if(self) {
        _route = route;
        _agency = agency;
        
    }
    return self;
}

-(void)parseDirections {

    NSString * routeURLBase = @"http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=";
    routeURLBase = [routeURLBase stringByAppendingString:self.agency];
    routeURLBase = [routeURLBase stringByAppendingString:@"&r="];
    self.routeURL = [routeURLBase stringByAppendingString:self.route.tag];
    NSLog(@"routeURL = %@", _routeURL);
    
    JYJDirectionFetchParser *parser = [[JYJDirectionFetchParser alloc] initWithURL: self.routeURL];
    
    [parser parseDirections];
    NSArray *temp = [parser returnStopsAndDirections];
    self.route.stops = temp[0];
    self.route.directions = temp[1];

}

@end
