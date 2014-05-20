//
//  JYJDataFetchModel.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import "JYJRouteListFetchModel.h"

@implementation JYJRouteListFetchModel 

-(JYJRouteListFetchModel *)initWithAgency:(NSString *)agency {
    self = [super init];
    if(self) {
        _agency = agency;
    }
    
    return self;
}

-(void) fetchRouteList {

    NSString * routeURLBase = @"http://webservices.nextbus.com/service/publicXMLFeed?command=routeList&a=";
    
    NSString * routeURL = [routeURLBase stringByAppendingString: self.agency];
    NSLog(@"routeURL = %@", routeURL);
    JYJRouteListParser *parser = [[JYJRouteListParser alloc] initWithURL: routeURL];
    
    [parser parseRouteList];
    
    NSArray * temp = [parser returnRoutesAndTags];
    
    self.routeList = temp[0];
    self.routeTagsSorted = temp[1];
    
    
    [self.routeList enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"Key: %@, Value: %@", key, obj);
    }];

}

@end
