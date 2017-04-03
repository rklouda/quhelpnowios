//
//  LoginTableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 3/30/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"

@interface RegisterTableViewController : UITableViewController
//@property (weak, nonatomic) IBOutlet UITableView *usersTableView;
{}

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UIButton *signIn;

@end
