//
//  JYJPredictionTVC.h
//  Next Bus App
//
//  Created by Jason Ji on 9/15/13.
//
//

#import <UIKit/UIKit.h>
#import "JYJPredictionFetchModel.h"

@interface JYJPredictionTVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) JYJPredictionFetchModel * model;
@property (strong, nonatomic) JYJRoute * route;
@property (strong, nonatomic) JYJDirection * direction;
@property (strong, nonatomic) JYJStop * stop;
@property (strong, nonatomic) NSString * agency;

@property (strong, nonatomic) NSString *routeTag;
@property (strong, nonatomic) NSString *directionTag;
@property (strong, nonatomic) NSString *stopTag;
@property (nonatomic) NSTimeInterval refreshInterval;

@property (strong, nonatomic) UITextView *routeDisplay;
@property (strong, nonatomic) UILabel *tableFooterLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSTimer *refreshTimer;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end
