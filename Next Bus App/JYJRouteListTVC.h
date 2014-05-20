//
//  JYJRouteListTVC.h
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import <UIKit/UIKit.h>
#import "JYJRouteListFetchModel.h"
#import "JYJDirectionTVC.h"
@interface JYJRouteListTVC : UITableViewController
@property (strong, nonatomic) NSString * agency;
@property(strong, nonatomic) JYJRouteListFetchModel * model;
@end
