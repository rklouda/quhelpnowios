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

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.navigationItem.hidesBackButton = NO;
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
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"agentDetail" sender:indexPath];
}
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"agentDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AgentDetailTableViewController *destViewController = segue.destinationViewController;
        destViewController.agentInfo= [[jsonData valueForKey:@"First_Name"] objectAtIndex:indexPath.row];
    }
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
