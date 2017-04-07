//
//  ClientDetailTableViewController.m
//  HelpNow
//
//  Created by Robert Klouda on 4/2/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import "ClientDetailTableViewController.h"
#import "SBJson.h"
#import "SVProgressHUD.h"
//test

@interface ClientDetailTableViewController ()

@end

@implementation ClientDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //  self.firstName.text = _clientInfo;
   // self.lastNameLabel.text = _lastName;
    
   _First_Name.delegate = self;
    _Last_Name.delegate = self;
    _Street.delegate = self;
    _City.delegate =self;
    _Zip_Code.delegate = self;
    _State.delegate = self;
    _Date.delegate = self;
    _Phone_Number.delegate = self;
    _Social_Security_Number.delegate = self;
    _Number_Of_Residents.delegate = self;
    _Agent_ID.delegate = self;
   
    self.Date.tag = 1;
    //    self.DOBTextField.inputView = dp;
    

   // UIBarButtonItem *email = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(doFile)];
   save= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    update= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(update1)];
    
    
   if (self.R_Last_Name) {
          NSLog(@"Edit Client: %@", self.R_Last_Name);
        
        
    self.navigationItem.rightBarButtonItem = update;
    update.enabled = NO;
        
   
       self.Client_ID.text = self.R_Client_ID;
       self.Last_Name.text = self.R_Last_Name;
      self.First_Name.text = self.R_First_Name;
        self.Street.text = self.R_Street;
       self.City.text = self.R_City;
       self.State.text = self.R_State;
        self.Zip_Code.text = self.R_Zip_Code;
        self.Date.text = self.R_Date;
        self.Phone_Number.text = self.R_Phone_Number;
        self.Social_Security_Number.text = self.R_Social_Security_Number;
      self.Number_Of_Residents.text = self.R_Number_Of_Residents;
       self.Agent_ID.text = self.R_Agent_ID;
    }
   else
    {
        NSLog(@"Create New client");
        self.navigationItem.rightBarButtonItem = save;
        save.enabled = NO;
}

}


-(void)save{
    
      NSLog(@"Save in Client pressed in ADD client detail");
    
    NSURL *url = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/addClientIOS.php"];
    // NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
//NSString *post =[[NSString alloc] initWithFormat:@"name=%@&last=%@",[_First_Name text],[_Last_Name text]];
    
    NSString *post =[[NSString alloc] initWithFormat:@"First_Name=%@&Last_Name=%@&Street=%@&City=%@&State=%@&Zip_Code=%@&Date=%@&Phone_Number=%@&Number_Of_Residents=%@&Agent_ID=%@&Social_Security_Number=%@",[_First_Name text],[_Last_Name text],[_Street text],[_City text],[_State text],[_Zip_Code text],[_Date text],[_Phone_Number text],[_Number_Of_Residents text],[_Agent_ID text],[_Social_Security_Number text]];
    
    
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
                                          NSLog(@"Client ADD SUCCESS");
                                          
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

[self.navigationController popViewControllerAnimated:YES];
}


-(void)update1
{
    NSLog(@"Update Client pressed in EDIT client detail");

  //  UIApplication.sharedApplication.networkActivityIndicatorVisible = true;
  //  [SVProgressHUD showWithStatus:@"Updating Client..."];
   // [SVProgressHUD dismiss];
    
    NSURL *url = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/updateClientIOS.php"];
    // NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSString *post = [[NSString alloc] initWithFormat:@"Client_ID=%@&First_Name=%@&Last_Name=%@&Street=%@&City=%@&State=%@&Zip_Code=%@&Date=%@&Phone_Number=%@&Number_Of_Residents=%@&Agent_ID=%@&Social_Security_Number=%@",[_Client_ID text],[_First_Name text],[_Last_Name text],[_Street text],[_City text],[_State text],[_Zip_Code text],[_Date text],[_Phone_Number text],[_Number_Of_Residents text],[_Agent_ID text],[_Social_Security_Number text]];
    
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
                                          NSLog(@"Client Modified SUCCESS");
                                        //  [self Alert:@"Successful"];
                                   UIApplication.sharedApplication.networkActivityIndicatorVisible = false;
                                           [SVProgressHUD dismiss];
                                      } else {
                                          
                                          NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                                          //             [self alertFailed:error_msg :@"Login Failure! Correct your credentials"];
                                          NSLog(@"Error %@", error_msg);
                                          
                                      }
                                      
                                  }
                                  ];
    [task resume];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Alert:(NSString*)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Client Modified"
                                                                   message:msg                                                            preferredStyle:UIAlertControllerStyleAlert]; // 1
    
    
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - Text Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    save.enabled = YES;
    update.enabled = YES;
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 9;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
