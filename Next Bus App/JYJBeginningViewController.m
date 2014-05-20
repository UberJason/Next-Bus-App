//
//  JYJViewController.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import "JYJBeginningViewController.h"
#import "JYJRouteListFetchModel.h"
#import "JYJRouteListTVC.h"

#import "JYJDirectionFetchModel.h"

@interface JYJBeginningViewController ()

@end

@implementation JYJBeginningViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
 
	
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"getRouteList"]) {

        JYJRouteListTVC * newController = (JYJRouteListTVC *)segue.destinationViewController;
        newController.agency = @"actransit";
        
    }
}


@end
