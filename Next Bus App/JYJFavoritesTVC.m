//
//  JYJFavoritesTVC.m
//  Next Bus App
//
//  Created by Jason Ji on 9/15/13.
//
//

#import "JYJFavoritesTVC.h"

@interface JYJFavoritesTVC ()

@end

@implementation JYJFavoritesTVC

#define TITLE @"title"
#define ROUTE_TAG @"routeTag"
#define STOP_TAG @"stopTag"
#define FAVORITES @"favorites"

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

-(NSMutableArray *)favorites {
    if(!_favorites) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _favorites = [[userDefaults objectForKey:FAVORITES] mutableCopy];
    }
    return _favorites;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.favorites = [[userDefaults objectForKey:FAVORITES] mutableCopy];
    NSLog(@"self.favorites count=%lu", (unsigned long)[self.favorites count]);
    [self.tableView reloadData];
}
#pragma mark - Table view delegate/data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.favorites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"favoritesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.favorites[indexPath.row][TITLE];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // if editingStyle == UITableViewCellEditingStyleDelete, remove stuff from model and call
    // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationLeft]
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.favorites removeObjectAtIndex:indexPath.row];
        [tableView endUpdates];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.favorites forKey:FAVORITES];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // maybe necessary to have the little + or - button?
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
    NSLog(@"indexPath=(%ld,%ld)", (long)indexPath.section, (long)indexPath.row);
    
    JYJPredictionTVC *newController = segue.destinationViewController;
    newController.routeTag = self.favorites[indexPath.row][ROUTE_TAG];
    newController.stopTag = self.favorites[indexPath.row][STOP_TAG];
    newController.agency = @"actransit";
}



@end
