//
//  AidTypeTableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 4/3/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
@interface AidTypeTableViewController : UITableViewController
{
    NSDictionary *Aidjsondata;
}
//@property(nonatomic,retain) NSDictionary *AidjsonData;
@property(nonatomic,retain) NSMutableArray *AidTypes;

@end
