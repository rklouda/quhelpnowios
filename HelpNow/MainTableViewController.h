//
//  MainTableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 4/1/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
@interface MainTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet NSString *userString, *userStringLast;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIButton *logOut;

@end
