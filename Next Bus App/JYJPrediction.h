//
//  JYJPrediction.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/6/13.
//
//

#import <Foundation/Foundation.h>
#import "JYJDirection.h"
#import "JYJRoute.h"
#import "JYJStop.h"

@interface JYJPrediction : NSObject

@property (strong, nonatomic) NSString * epochTime;
@property (strong, nonatomic) NSString * seconds;
@property (strong, nonatomic) NSString * minutes;
@property (nonatomic) BOOL isDeparture;
@property (nonatomic) BOOL affectedByLayover;
@property (strong, nonatomic) NSString * dirTag;
@property (strong, nonatomic) NSString * dirString;
@property (strong, nonatomic) NSString * vehicle;
@property (strong, nonatomic) NSString * block;
@property (strong, nonatomic) NSString * tripTag;

@end
