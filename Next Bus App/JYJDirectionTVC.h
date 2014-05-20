//
//  JYJDirectionTVC.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import <UIKit/UIKit.h>
#import "JYJDirectionFetchModel.h"
#import "JYJRoute.h"
@interface JYJDirectionTVC : UITableViewController

@property (strong, nonatomic) JYJRoute * route;
@property (strong, nonatomic) NSString * agency;
@property (strong, nonatomic) JYJDirectionFetchModel * model;

@end
