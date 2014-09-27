//
//  JYJDirectionTVC.m
//  Next Bus App
//
//  Created by Ji, Jason Y on 8/5/13.
//
//

#import "JYJDirectionTVC.h"
#import "JYJDirection.h"
#import "JYJStopListTVC.h"

@interface JYJDirectionTVC ()

@end

@implementation JYJDirectionTVC

@synthesize model = _model;

-(JYJDirectionFetchModel *)model {
    if(!_model) _model = [[JYJDirectionFetchModel alloc] initWithRoute: _route
                                                                agency: _agency];
    return _model;
}

-(void)setModel:(JYJDirectionFetchModel *)model {
    _model = model;
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    
    dispatch_queue_t dirfetchQ = dispatch_queue_create("direction fetching queue", NULL);
    dispatch_async(dirfetchQ, ^ {
        [self.model parseDirections];
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.tableView reloadData];
        });
    });

}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [[self.model.route.directions allKeys] count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Select a direction:";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Direction Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow: indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

- (NSString *) titleForRow:(NSInteger)row {
    
    NSString * directionTag = [self.model.route.directions allKeys][row];
    JYJDirection * direction = self.model.route.directions[directionTag];
    return direction.title;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSString *directionTag = [self.model.route.directions allKeys][path.row];
    
    JYJStopListTVC * newController = (JYJStopListTVC *)segue.destinationViewController;
    
    newController.route = self.model.route;
    newController.agency = self.agency;
    newController.direction = self.model.route.directions[directionTag];
}



@end
