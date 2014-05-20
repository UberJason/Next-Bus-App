//
//  JYJStop.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import <Foundation/Foundation.h>

@interface JYJStop : NSObject

@property (strong, nonatomic) NSString * tag;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSNumber * lat;
@property (strong, nonatomic) NSNumber * lon;
@property (strong, nonatomic) NSString * stopId;

@end
