//
//  TemplateViewController.m
//  Take5
//
//  Created by Scott Gerring on 21/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TemplateViewController.h"
#import "Take5WebClient.h"

@implementation TemplateViewController
{
	NSDictionary* templateModel;
	NSArray* sectionsModel;
}

NSString* StringFielCelldId = @"StringField";
NSString* BooleanFieldCellId = @"BooleanField";
NSString* ComboFieldCellId = @"ComboField";

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
	Take5WebClient* client = [[Take5WebClient alloc] init];
	templateModel = [client fetchTemplate:@"DownerEdi"];
	sectionsModel = [templateModel valueForKey:@"sections"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionsModel count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[[sectionsModel objectAtIndex:section] objectForKey:@"fields"] count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[sectionsModel objectAtIndex:section] valueForKey:@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int sectionId = [indexPath indexAtPosition:0];
	int fieldId = [indexPath indexAtPosition:1];
	
	NSDictionary* field = [[[sectionsModel objectAtIndex: sectionId] objectForKey:@"fields"] objectAtIndex:fieldId];
	UITableViewCell* cell = nil;
	if ([@"String" isEqualToString:[field valueForKey:@"type" ]])
	{
		cell = [tableView dequeueReusableCellWithIdentifier:StringFielCelldId];
    }
	else if ([@"Boolean" isEqualToString:[field valueForKey:@"type" ]])
	{
		cell = [tableView dequeueReusableCellWithIdentifier:BooleanFieldCellId];
	}
	else if ([@"ComboBox" isEqualToString:[field valueForKey:@"type"]])
	{
		cell = [tableView dequeueReusableCellWithIdentifier:ComboFieldCellId];
	}
	else
	{
		cell = [[UITableViewCell alloc] init];
	}
	
	[[cell textLabel] setText:[field objectForKey:@"label"]];
	[[cell detailTextLabel] setText:@"ENTER ME"];
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
