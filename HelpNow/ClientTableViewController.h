//
//  ClientTableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 3/29/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
@interface ClientTableViewController : UITableViewController
{
    NSDictionary *jsonData;

    //  __block NSArray *Agents;
}
@property(nonatomic,retain) NSMutableArray *Clients;
//@property (nonatomic, strong) UISearchController *searchController;
//@property (nonatomic, readonly) NSArray *searchResults;
//@property (strong, nonatomic) UISearchController *searchController;
@end

