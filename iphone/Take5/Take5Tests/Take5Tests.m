//
//  Take5Tests.m
//  Take5Tests
//
//  Created by Scott Gerring on 1/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Take5Tests.h"
#import "Take5WebClient.h"

@implementation Take5Tests
{
	Take5WebClient* webClient;
}

- (void)setUp
{
    [super setUp];
    webClient = [[Take5WebClient alloc] init];	
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testFetchTemplates
{
	NSArray* templates = [webClient fetchTemplateNames];
	NSLog(@"Templates: %@", templates);
	STAssertNotNil(templates, @"Templates shouldn't be nil");
	STAssertTrue([templates count] != 0, @"There should be templates");
}

- (void)testFetchTemplate
{
	NSDictionary* template = [webClient fetchTemplate:@"DownerEdi"];
	NSLog(@"Template: %@", template);
	STAssertNotNil(template, @"The template shouldn't be nil");
	STAssertTrue([[template allKeys] count] > 0, @"There should be some templates");
}

@end
