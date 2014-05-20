//
//  JYJDataFetchModel.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import <Foundation/Foundation.h>
#import "JYJRouteListParser.h"

@interface JYJRouteListFetchModel : NSObject

@property (strong, nonatomic) NSMutableDictionary * routeList;
@property (strong, nonatomic) NSMutableArray * routeTagsSorted;
@property (strong, nonatomic) NSString * agency;

-(JYJRouteListFetchModel *) initWithAgency: (NSString *) agency;

-(void) fetchRouteList;

@end
