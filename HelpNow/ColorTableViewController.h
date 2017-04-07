//
//  ColorTableTableViewController.h
//  MyRaffleTickets
//
//  Created by Robert Klouda on 11/5/15.
//  Copyright (c) 2015 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorTableViewController : UITableViewController
{
    NSDictionary *Aidjsondata;
}
//@property(nonatomic,retain) NSDictionary *AidjsonData;
@property(nonatomic,retain) NSMutableArray *AidTypes;
@property (nonatomic, retain) NSString *AidTypeSelected;

@end
