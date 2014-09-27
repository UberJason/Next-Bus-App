//
//  TwoLabelTableViewCell.h
//  Next Bus App
//
//  Created by Jason Ji on 9/27/14.
//
//

#import <UIKit/UIKit.h>

@interface TwoLabelTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;

@end
