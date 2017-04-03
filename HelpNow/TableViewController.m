//
//  TableViewController.m
//  HelpNow
//
//  Created by Robert Klouda on 3/29/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import "TableViewController.h"
#import "SVProgressHUD.h"
#import "AgentDetailTableViewController.h"

@interface TableViewController () ///<, UISearchControllerDelegate>
//@property (strong, nonatomic) UISearchController *controller;
//@property (strong, nonatomic) NSArray *results;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.navigationItem.hidesBackButton = NO;
    
//    SearchResultsViewController *searchResults = (SearchResultsViewController *)self.controller.searchResultsController;
//    [self addObserver:searchResults forKeyPath:@"results" options:NSKeyValueObservingOptionNew context:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   // self.Agents = [[NSMutableArray alloc] init];
   

}
-(void)viewWillAppear:(BOOL)animated{
 [self loadAgentData];

}

-(void)loadAgentData{
    [SVProgressHUD showWithStatus:@"Loading Agents..."];
   
    __block NSArray *weakArray; // = _Agents;
    
    NSURL *URL = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/agentIOS.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                      NSString *responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      SBJsonParser *jsonParser = [SBJsonParser new];
                                      jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                                      
                                      if(error) {
                                          NSLog(@"%@", error);
                                      }
                                      NSLog(@"Jason Parsed for TableView:%@",jsonData);
                                      //  self.Agents = [jsonData valueForKey:@"First_Name"];
                                      
                                      
                                      weakArray = [[jsonData valueForKey:@"First_Name"] mutableCopy];
                                    //  weakArray = [[jsonData allValues] mutableCopy];
                                      
                                      // self.Agents = [weakArray mutableCopy];
                                      
                                      NSLog(@"The Agent array INSIDE is = %@", weakArray);
                                      [self end:jsonData];
                                  }];
    [task resume];
    

}

- (void)end:(NSDictionary *)agents
{
   
   // self.Agents = [agents mutableCopy];
    self.Agents = [[agents valueForKey:@"First_Name"] mutableCopy];
    NSLog(@"The Agent OUTSIDE array is = %@ count %lu", self.Agents, self.Agents.count);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:NO];
          [SVProgressHUD dismiss];
    });
}

-(void) updateTable
{
    [self.tableView reloadData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
   // NSLog(@"Count:%lu", self.Agents.count);
    
    return self.Agents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    // Configure the cell...
    
   // cell.textLabel.text = [self.Agents objectAtIndex:indexPath.row];
   NSString *fullName = [NSString stringWithFormat:@"%@ %@",[[jsonData valueForKey:@"First_Name"]objectAtIndex:indexPath.row], [[jsonData valueForKey:@"Last_Name"] objectAtIndex:indexPath.row]];
    cell.textLabel.text = fullName;//[[jsonData valueForKey:@"First_Name"] objectAtIndex:indexPath.row];
    
    NSString *ID = [NSString stringWithFormat:@"ID: %@",[[jsonData valueForKey:@"Agent_ID"]objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = ID; //[[jsonData valueForKey:@"Agent_ID"] objectAtIndex:indexPath.row];
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    
    if ([[segue identifier] isEqualToString:@"addAgent"]) {
        
        //   NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AgentDetailTableViewController *destinationViewController = (AgentDetailTableViewController *)segue.destinationViewController;
        //  destinationViewController.self.clientInfo = [[jsonData valueForKey:@"First_Name"] objectAtIndex:indexPath.row];
        destinationViewController.title = @"Add New Client";
        //   UIBarButtonItem *save=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(addClient)];
        //  destinationViewController.navigationItem.rightBarButtonItem=save;
        
        
        
    }
    
    if ([[segue identifier] isEqualToString:@"editAgent"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
       AgentDetailTableViewController *destinationViewController = (AgentDetailTableViewController*)segue.destinationViewController;
        destinationViewController.self.R_First_Name= [[jsonData valueForKey:@"First_Name"] objectAtIndex:indexPath.row];
        destinationViewController.self.R_Last_Name = [[jsonData valueForKey:@"Last_Name"] objectAtIndex:indexPath.row];
        destinationViewController.self.R_City= [[jsonData valueForKey:@"City"] objectAtIndex:indexPath.row];
        destinationViewController.self.R_State = [[jsonData valueForKey:@"State"] objectAtIndex:indexPath.row];
        destinationViewController.self.R_Zip_Code= [[jsonData valueForKey:@"Zip_Code"] objectAtIndex:indexPath.row];
        destinationViewController.self.R_Phone_Number = [[jsonData valueForKey:@"Phone_Number"] objectAtIndex:indexPath.row];
        destinationViewController.self.R_Date= [[jsonData valueForKey:@"Date"] objectAtIndex:indexPath.row];
        destinationViewController.self.R_Number_Of_Residents = [[jsonData valueForKey:@"Number_Of_Residents"] objectAtIndex:indexPath.row];
        destinationViewController.self.R_Agent_ID= [[jsonData valueForKey:@"Agent_ID"] objectAtIndex:indexPath.row];
        destinationViewController.self.R_Client_ID= [[jsonData valueForKey:@"Client_ID"] objectAtIndex:indexPath.row];
        
        destinationViewController.title = @"Edit Client";
        //  destinationViewController.toolbarItems = nil;
        
    }
    
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
        
        NSLog(@"Delete Agent ");
        
        
        NSURL *url = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/deleteAgentIOS.php"];
        // NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSString *post =[[NSString alloc] initWithFormat:@"Agent_ID=%@",[[jsonData valueForKey:@"Agent_ID"] objectAtIndex:indexPath.row]];
        
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
                                              NSLog(@"ERROR Deleting AGENT:%@", error);
                                          }
                                          
                                          if([responseData isEqual:@"true"])
                                          {
                                              NSLog(@"Agent Delete SUCCESS");
                                              
                                              // [self performSegueWithIdentifier: @"logOut" sender: self];
                                              
                                              //  [self.navigationController popViewControllerAnimated:YES];
                                              
                                          } else {
                                              
                                              NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                                              //             [self alertFailed:error_msg :@"Login Failure! Correct your credentials"];
                                              NSLog(@"Error %@", error_msg);
                                              
                                          }
                                          
                                      }
                                      ];
        [task resume];
        
        
        
        [self.Agents removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        
    }// else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    // }
}
# pragma mark - Search Results Updater
/*
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    // filter the search results
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [cd] %@", self.controller.searchBar.text];
    self.results = [self.Agents filteredArrayUsingPredicate:predicate];
    
    // NSLog(@"Search Results are: %@", [self.results description]);
}

- (IBAction)searchButtonPressed:(id)sender {
    
    // present the search controller
    [self presentViewController:self.controller animated:YES completion:nil];
    
}


# pragma mark - Search Controller Delegate (optional)

- (void)didDismissSearchController:(UISearchController *)searchController {
    
    // called when the search controller has been dismissed
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    
    // called when the serach controller has been presented
}

- (void)presentSearchController:(UISearchController *)searchController {
    
    // if you want to implement your own presentation for how the search controller is shown,
    // you can do that here
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    
    // called just before the search controller is dismissed
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    
    // called just before the search controller is presented
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
