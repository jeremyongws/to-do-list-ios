//
//  ViewController.m
//  ToDoList
//
//  Created by Jeremy Ong on 04/04/2016.
//  Copyright © 2016 Jeremy Ong. All rights reserved.
//

#import "ToDoViewController.h"

@interface ToDoViewController () <UITableViewDelegate, UITableViewDataSource >
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *todos;
@property NSMutableArray *colors;
@property (weak, nonatomic) IBOutlet UITextField *toDoTextField;
@property NSInteger previousCellClickedIndex;

@end

@implementation ToDoViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.todos = [[NSMutableArray alloc] initWithObjects:@"commit lulz", @"push to github", @"c0de", @"commit lulz again", nil];
	self.colors = [[NSMutableArray alloc] initWithObjects:[UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor], [UIColor whiteColor], nil];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Appear" message:[self.todos objectAtIndex:indexPath.row] preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *ok = [UIAlertAction actionWithTitle:@"DISMISS" style:UIAlertActionStyleDestructive handler:nil];
	[alert addAction:ok];
	[self.colors replaceObjectAtIndex:[self previousCellClickedIndex] withObject:[UIColor whiteColor]];
	[self presentViewController:alert animated:YES completion:nil];
	UIColor *color = [UIColor colorWithRed:(arc4random_uniform(255)/255.0) green:(arc4random_uniform(255)/255.0) blue:(arc4random_uniform(255)/255.0) alpha:1];
	[self.colors replaceObjectAtIndex:[indexPath row] withObject:color];
	[self setPreviousCellClickedIndex:[indexPath row]];
	[self.tableView reloadData];
}

- (IBAction)onAddTaskPressed:(id)sender {
	NSString *task = self.toDoTextField.text;
	[[self toDoTextField] resignFirstResponder];
	[[self todos] addObject:task];
	[[self colors] addObject:[UIColor whiteColor]];
	[[self tableView] reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	[cell.textLabel setText:[self.todos objectAtIndex:[indexPath row]]];
	[cell setBackgroundColor:[self.colors objectAtIndex:[indexPath row]]];
	
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.todos count];
}

@end
