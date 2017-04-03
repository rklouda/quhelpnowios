//
//  AgentDetailTableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 4/2/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentDetailTableViewController : UITableViewController
{
NSDictionary *jsonDict;

}
@property (weak, nonatomic) IBOutlet NSString *agentInfo;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@end
