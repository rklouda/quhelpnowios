//
//  TableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 3/29/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "SearchResultsViewController.h"

@interface TableViewController : UITableViewController
{
    NSDictionary *jsonData;
  
  //  __block NSArray *Agents;
}
@property(nonatomic,retain) NSMutableArray *Agents;
//@property (nonatomic, strong) UISearchController *searchController;
//@property (nonatomic, readonly) NSArray *searchResults;
@end
