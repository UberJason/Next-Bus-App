//
//  JYJPredictionTVC.m
//  Next Bus App
//
//  Created by Jason Ji on 9/15/13.
//
//

#import "JYJPredictionTVC.h"

#define TITLE @"title"
#define ROUTE_TAG @"routeTag"
#define STOP_TAG @"stopTag"
#define FAVORITES @"favorites"


@interface JYJPredictionTVC ()

@end

@implementation JYJPredictionTVC

-(JYJPredictionFetchModel *)model {
    if(!_model){
        
        if(self.route) {
            
            _model = [[JYJPredictionFetchModel alloc] initWithRoute:_route
                                                          direction:_direction
                                                               stop:_stop
                                                             agency:_agency];
        }
        else if(self.routeTag) {
            _model = [[JYJPredictionFetchModel alloc] initWithRouteTag:_routeTag stopTag:_stopTag agency:_agency];
        }
    }
    return _model;
}

-(NSDateFormatter *)dateFormatter {
    if(!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"hh:mm:ss aa";
    }
    return _dateFormatter;
}

-(UILabel *)tableFooterLabel {
    if(!_tableFooterLabel) {
        _tableFooterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        _tableFooterLabel.textColor = [UIColor grayColor];
        _tableFooterLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _tableFooterLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.routeDisplay = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 59)];
    self.routeDisplay.backgroundColor = [UIColor clearColor];
    self.routeDisplay.userInteractionEnabled = NO;
    
    self.routeDisplay.font = [UIFont systemFontOfSize:14];
    self.tableView.tableHeaderView = self.routeDisplay;
    self.tableView.tableFooterView = self.tableFooterLabel;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    self.refreshInterval = 5.0;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshPredictions];
    NSLog(@"routeTag: %@", self.model.route.tag);
    NSLog(@"stopTag: %@", self.model.stop.tag);
    NSLog(@"URL: %@", self.model.routeURL);
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.refreshTimer invalidate];
}
#pragma mark - Table view delegate/data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.model.predictions count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Predictions";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Prediction Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    JYJPrediction *prediction = self.model.predictions[indexPath.row];
    
    cell.textLabel.text = prediction.dirString;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ min", prediction.minutes];
    
    return cell;
}

#pragma mark - alert view delegate method

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"dismissing with buttonIndex=%ld", (long)buttonIndex);
    if(buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString *title = textField.text;
        NSLog(@"%@",title);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *favorites = [[defaults objectForKey: FAVORITES] mutableCopy];
        if(!favorites)
            favorites = [NSMutableArray new];
        NSDictionary *newFavorite = @{ROUTE_TAG : self.route.tag, STOP_TAG : self.stop.tag, TITLE : title};
        
        [favorites addObject:newFavorite];
        [defaults setObject:favorites forKey:FAVORITES];
        
        [defaults synchronize];
    }
    
}

#pragma mark - helper methods

-(void)refresh:(UIRefreshControl *)refreshControl {
    [self refreshPredictions];
    [refreshControl endRefreshing];
}

-(void)refreshPredictions {
    NSLog(@"Refresh!");
    
    dispatch_queue_t predfetchQ = dispatch_queue_create("prediction fetching queue", NULL);
    dispatch_async(predfetchQ, ^ {
        BOOL success = [self.model parsePredictions];
        if(success) {
            [self.model.predictions sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                JYJPrediction *pred1 = (JYJPrediction *)obj1;
                JYJPrediction *pred2 = (JYJPrediction *)obj2;
                
                return ( [pred1.epochTime longLongValue] > [pred2.epochTime longLongValue]? (NSComparisonResult)NSOrderedDescending : (NSComparisonResult)NSOrderedAscending );
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                self.routeDisplay.text = [NSString stringWithFormat:@"Agency: %@\nRoute: %@\nStop: %@", self.model.agencyTitle, self.model.route.title, self.model.stop.title];
                self.tableFooterLabel.text = [NSString stringWithFormat:@"   Last Updated: %@", [self.dateFormatter stringFromDate:[NSDate date]]];
                [self.tableView reloadData];
                [self setNewRefreshTimer];
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setNewRefreshTimer];
                self.tableFooterLabel.text = [NSString stringWithFormat:@"   Last Updated: %@ (Failed)", [self.dateFormatter stringFromDate:[NSDate date]]];
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to fetch data. Check your data connection and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            });
        }
    });
}

-(void)setNewRefreshTimer {
    if(self.refreshTimer.isValid)
        [self.refreshTimer invalidate];
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval: MIN(self.refreshInterval,[self.model shortestRefreshInterval]) target:self selector:@selector(refreshPredictions) userInfo:nil repeats:NO];
}

- (IBAction)addToFavorites:(UIBarButtonItem *)sender {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"New Favorite" message:@"Enter a title for this route:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    view.alertViewStyle = UIAlertViewStylePlainTextInput;
    [view show];
}

@end
