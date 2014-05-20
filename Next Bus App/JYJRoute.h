//
//  JYJRoute.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import <Foundation/Foundation.h>

@interface JYJRoute : NSObject
@property (strong, nonatomic) NSString * tag;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSMutableDictionary * stops;
@property (strong, nonatomic) NSMutableDictionary * directions;

@end
