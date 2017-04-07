//
//  AidRequestTableViewController.m
//  HelpNow
//
//  Created by Robert Klouda on 4/3/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import "AidRequestTableViewController.h"
#import "SVProgressHUD.h"
#import "AidRequestDetailTableViewController.h"
#import "SBJson.h"

@interface AidRequestTableViewController ()

@end

@implementation AidRequestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //   NSLog(@"Agentjsondate in AidRequestTVC: %@", self.AidjsonData);
    self.navigationItem.hidesBackButton = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadAidRequestData];
//    [self loadAgentRequestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadAidRequestData{
    [SVProgressHUD showWithStatus:@"Loading AidTypes..."];
    
    __block NSArray *weakArray; // = _Agents;
    
    NSURL *URL = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/aidRequestsIOS.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                      NSString *responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      SBJsonParser *jsonParser = [SBJsonParser new];
                                      self.AidjsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                                      
                                      if(error) {
                                          NSLog(@"%@", error);
                                      }
                                      NSLog(@"Jason Parsed for TableView:%@",self.AidjsonData);
                                      //  self.Agents = [jsonData valueForKey:@"First_Name"];
                                      
                                      
                                  //    weakArray = [[self.AidjsonData valueForKey:@"First_Name"] mutableCopy];
                                      //  weakArray = [[jsonData allValues] mutableCopy];
                                      
                                      // self.Agents = [weakArray mutableCopy];
                                      
                                  //    NSLog(@"The Agent array INSIDE is = %@", weakArray);
                                      [self end:self.AidjsonData];
                                  }];
    [task resume];
    
    
}- (void)end:(NSDictionary *)agents
{
    
    // self.Agents = [agents mutableCopy];
    self.AidRequests= [[agents valueForKey:@"Request_ID"] mutableCopy];
    NSLog(@"The AidRequest OUTSIDE array is = %@ count %lu", self.AidRequests, self.AidRequests.count);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:NO];
        [SVProgressHUD dismiss];
    });
}

-(void) updateTable
{
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadAidRequestData];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.AidRequests.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
   
    if ([[segue identifier] isEqualToString:@"editAidRequest"]) {
               NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AidRequestDetailTableViewController *destinationViewController = (AidRequestDetailTableViewController*)segue.destinationViewController;
     //   destinationViewController.self.AidjsonData= self.AidjsonData;
        destinationViewController.self.agentjsonData = self.AgentjsonData;
     destinationViewController.self.R_Request_ID = [[self.AidjsonData valueForKey:@"Request_ID"] objectAtIndex:indexPath.row];
         destinationViewController.self.R_Date_Requested= [[self.AidjsonData valueForKey:@"Date_Requested"] objectAtIndex:indexPath.row];
         destinationViewController.self.Amount_Requested = [[self.AidjsonData valueForKey:@"Amount_Requested"] objectAtIndex:indexPath.row];
         destinationViewController.self.R_Decision = [[self.AidjsonData valueForKey:@"Decision"] objectAtIndex:indexPath.row];
         destinationViewController.self.R_Client_Notes = [[self.AidjsonData valueForKey:@"Client_Notes"] objectAtIndex:indexPath.row];
         destinationViewController.self.R_Aid_ID= [[self.AidjsonData valueForKey:@"Aid_ID"] objectAtIndex:indexPath.row];
         destinationViewController.self.R_Documentation_Provided = [[self.AidjsonData valueForKey:@"Documentation_Provided"] objectAtIndex:indexPath.row];
        
        
        //  destinationViewController.title = @"Edit Agent";
        //  destinationViewController.toolbarItems = nil;
        
    }
    if ([[segue identifier] isEqualToString:@"addAidRequest"]) {
      //  NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AidRequestDetailTableViewController *destinationViewController = (AidRequestDetailTableViewController*)segue.destinationViewController;
        //   destinationViewController.self.AidjsonData= self.AidjsonData;
        destinationViewController.self.agentjsonData = self.AgentjsonData;

        //  destinationViewController.title = @"Edit Agent";
        //  destinationViewController.toolbarItems = nil;
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    // Configure the cell...
    
    // cell.textLabel.text = [self.Agents objectAtIndex:indexPath.row];
   NSString *AidRequest = [NSString stringWithFormat:@"ID: %@ Date Requested: %@",[[self.AidjsonData valueForKey:@"Request_ID"]objectAtIndex:indexPath.row], [[self.AidjsonData valueForKey:@"Date_Requested"] objectAtIndex:indexPath.row]];
    cell.textLabel.text = AidRequest;//[[jsonData valueForKey:@"First_Name"] objectAtIndex:indexPath.row];
    
   NSString *Time = [NSString stringWithFormat:@"Decision: %@", [[self.AidjsonData valueForKey:@"Decision"] objectAtIndex:indexPath.row]];
   cell.detailTextLabel.text = Time;
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSLog(@"delete AidRequest pressed");
        
        
        NSURL *url = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/deleteAidRequestIOS.php"];
        // NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSString *post =[[NSString alloc] initWithFormat:@"Request_ID=%@",[[self.AidjsonData valueForKey:@"Request_ID"] objectAtIndex:indexPath.row]];
        
        NSLog(@"PostData: %@",post);
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          // ...
                                          NSString *responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                          
                                          NSLog(@"Response ==>%@", responseData);
                                          
                                          if(error) {
                                              NSLog(@"ERROR Saving new Client:%@", error);
                                          }
                                          
                                          if([responseData isEqual:@"true"])
                                          {
                                              NSLog(@"Aid Request Deleted SUCCESS");
                                              
                                              // [self performSegueWithIdentifier: @"logOut" sender: self];
                                              
                                              //  [self.navigationController popViewControllerAnimated:YES];
                                              
                                          } else {
                                              
                                        
                                              NSLog(@"Error %@", error);
                                              
                                          }
                                          
                                      }
                                      ];
        [task resume];
        
        
        
        [self.AidRequests removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        
    }// else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    // }
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
    // Pass the selected object to the new view controller.
}
*/

@end
