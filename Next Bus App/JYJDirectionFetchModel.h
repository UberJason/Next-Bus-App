//
//  JYJDirectionFetchModel.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import <Foundation/Foundation.h>
#import "JYJDirectionFetchParser.h"
#import "JYJRoute.h"

@interface JYJDirectionFetchModel : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) JYJRoute * route;
@property (strong, nonatomic) NSString * agency;
-(JYJDirectionFetchModel *) initWithRoute:(JYJRoute *)route
                                   agency:(NSString *) agency;
-(void) parseDirections;

@end
