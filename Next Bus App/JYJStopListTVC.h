//
//  JYJStopListTVC.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import <UIKit/UIKit.h>
#import "JYJDirection.h"
#import "JYJRoute.h"
#import "JYJStop.h"
#import "JYJPredictionTVC.h"

@interface JYJStopListTVC : UITableViewController

@property (strong, nonatomic) JYJRoute * route;
@property (strong, nonatomic) JYJDirection * direction;
@property (strong, nonatomic) NSString * agency;

@end
