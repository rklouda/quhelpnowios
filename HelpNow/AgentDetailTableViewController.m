//
//  AgentDetailTableViewController.m
//  HelpNow
//
//  Created by Robert Klouda on 4/2/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import "AgentDetailTableViewController.h"
#import "SVProgressHUD.h"

@interface AgentDetailTableViewController ()

@end

@implementation AgentDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  self.firstName.text = _clientInfo;
    // self.lastNameLabel.text = _lastName;
    
    _First_Name.delegate = self;
    _Last_Name.delegate = self;
    _Street.delegate = self;
    _City.delegate =self;
    _Zip_Code.delegate = self;
    _Date_Hired.delegate = self;
    _Phone_Number.delegate = self;
    _Agent_Email.delegate = self;
    _State.delegate = self;
    _Agent_ID.delegate = self;
    
    self.Date_Hired.tag = 1;
    //    self.DOBTextField.inputView = dp;
    
    
    // UIBarButtonItem *email = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(doFile)];

        //    [self disableTextFields];
        
        self.Last_Name.text = self.R_Last_Name;
        self.First_Name.text = self.R_First_Name;
        self.Street.text = self.R_Street;
        self.City.text = self.R_City;
        self.Zip_Code.text = self.R_Zip_Code;
        self.Date_Hired.text = self.R_Date_Hired;
        self.Phone_Number.text = self.R_Phone_Number;
        self.Agent_Email.text = self.R_Agent_Email;
        self.State.text = self.R_State;
        self.Agent_ID.text = self.R_Agent_ID;
        
 
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)Alert:(NSString*)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Agent Modified"
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
