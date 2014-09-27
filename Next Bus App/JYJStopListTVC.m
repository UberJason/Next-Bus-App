//
//  JYJStopListTVC.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import "JYJStopListTVC.h"

@interface JYJStopListTVC ()

@end

@implementation JYJStopListTVC


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView reloadData];
    NSLog(@"Route: %@, Direction: %@", self.route.tag, self.direction.title);

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.direction.stopTags count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Select a stop:";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Bus Stop";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

-(NSString *)titleForRow:(NSInteger)row {
    
    NSString * tag = self.direction.stopTags[row];
    JYJStop *stop = self.route.stops[tag];
    return stop.title;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];

    JYJStop *stop = self.route.stops[self.direction.stopTags[path.row]];
    
    JYJPredictionTVC * newController = (JYJPredictionTVC *)segue.destinationViewController;
    
    newController.stop = stop;
    newController.route = self.route;
    newController.direction = self.direction;
    newController.agency = self.agency;
    
    NSLog(@"Passing stop: %@",stop.tag);
    NSLog(@"Passing route: %@",self.route.tag);
    NSLog(@"Passing direction: %@", self.direction.title);
    NSLog(@"Passing agency: %@", self.agency);
}


@end
