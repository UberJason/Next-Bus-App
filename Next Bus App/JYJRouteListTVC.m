//
//  JYJRouteListTVC.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import "JYJRouteListTVC.h"

@interface JYJRouteListTVC ()

@end

@implementation JYJRouteListTVC

@synthesize model = _model;

-(JYJRouteListFetchModel *)model {
    if(!_model) _model = [[JYJRouteListFetchModel alloc] initWithAgency: _agency];
    return _model;
}

-(void) setModel:(JYJRouteListFetchModel *)model {
    _model = model;
    [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.agency = @"actransit";
    NSLog(@"AAAAA");
    
}

-(void) viewWillAppear:(BOOL)animated {
    
    dispatch_queue_t fetchQ = dispatch_queue_create("route list fetching queue", NULL);
    dispatch_async(fetchQ, ^ {
        [self.model fetchRouteList];
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.tableView reloadData];
        });
    });
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model.routeList count];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Bus Route";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow: indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Select a route:";
}

-(NSString *) titleForRow:(NSInteger)row {

    JYJRoute * currentRoute = self.model.routeList[self.model.routeTagsSorted[row]];    
    return currentRoute.title;

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    JYJRoute * currentRoute = self.model.routeList[self.model.routeTagsSorted[path.row]];
    
    JYJDirectionTVC * newController = (JYJDirectionTVC *)segue.destinationViewController;
    newController.agency = self.agency;
    newController.route = currentRoute;
    NSLog(@"Passing the route which has this tag: %@", currentRoute.tag);
}

@end
