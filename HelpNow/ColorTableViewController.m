//
//  ColorTableTableViewController.m
//  MyRaffleTickets
//
//  Created by Robert Klouda on 11/5/15.
//  Copyright (c) 2015 Robert Klouda. All rights reserved.
//

#import "ColorTableViewController.h"
#import "SVProgressHUD.h"
#import "SBJson.h"
@interface ColorTableViewController ()

@end

@implementation ColorTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        
     //   UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(Cancel)];
        
      //  [[self navigationItem] setLeftBarButtonItem:clearItem];
        
        
    }
    return self;
}
- (void)Cancel ///:(id)sender
{
    NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = NO;
    
 //   _AidTypeSelected = [[NSUserDefaults standardUserDefaults] objectForKey:@"AidTypeSelected"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadAidTypeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadAidTypeData{
    [SVProgressHUD showWithStatus:@"Loading AidTypes..."];
    
    __block NSArray *weakArray; // = _Agents;
    
    NSURL *URL = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/aidTypesIOS.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                      NSString *responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      SBJsonParser *jsonParser = [SBJsonParser new];
                                      Aidjsondata = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                                      
                                      if(error) {
                                          NSLog(@"%@", error);
                                      }
                                      NSLog(@"Jason Parsed for TableView:%@",Aidjsondata);
                                      //  self.Agents = [jsonData valueForKey:@"First_Name"];
                                      
                                      
                                      weakArray = [[Aidjsondata valueForKey:@"First_Name"] mutableCopy];
                                      //  weakArray = [[jsonData allValues] mutableCopy];
                                      
                                      // self.Agents = [weakArray mutableCopy];
                                      
                                      NSLog(@"The Agent array INSIDE is = %@", weakArray);
                                      [self end:Aidjsondata];
                                  }];
    [task resume];
    
    
}

- (void)end:(NSDictionary *)agents
{
    
    // self.Agents = [agents mutableCopy];
    self.AidTypes= [[agents valueForKey:@"First_Name"] mutableCopy];
    NSLog(@"The Agent OUTSIDE array is = %@ count %lu", self.AidTypes, self.AidTypes.count);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:NO];
        [SVProgressHUD dismiss];
    });
}

-(void) updateTable
{
    [self.tableView reloadData];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.AidTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    // Configure the cell...
    
    // cell.textLabel.text = [self.Agents objectAtIndex:indexPath.row];
    NSString *AidType = [NSString stringWithFormat:@"ID: %@ Catagory: %@",[[Aidjsondata valueForKey:@"Aid_ID"]objectAtIndex:indexPath.row], [[Aidjsondata valueForKey:@"Category"] objectAtIndex:indexPath.row]];
    cell.textLabel.text = AidType;//[[jsonData valueForKey:@"First_Name"] objectAtIndex:indexPath.row];
    
    NSString *Time = [NSString stringWithFormat:@" Time Restriction: %@ days", [[Aidjsondata valueForKey:@"Time_Restriction"] objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = Time;
    
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *tableCell = [tableView cellForRowAtIndexPath:indexPath];
    // BOOL isSelected = (tableCell.accessoryType == UITableViewCellAccessoryCheckmark);
    
    // if (isSelected) {
    tableCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    _AidTypeSelected = [[Aidjsondata valueForKey:@"Aid_ID"] objectAtIndex:indexPath.row];
    //  [self.delegate Object:colorName];
    
    NSLog(@"AidType Selected %@", _AidTypeSelected);
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:_AidTypeSelected forKey:@"AidTypeSelected"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];   // }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 */
@end
