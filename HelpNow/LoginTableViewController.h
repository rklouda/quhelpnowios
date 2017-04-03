//
//  LoginTableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 3/30/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"

@interface LoginTableViewController : UITableViewController
//@property (weak, nonatomic) IBOutlet UITableView *usersTableView;
{}

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet NSString *first_name, *last_name;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end
