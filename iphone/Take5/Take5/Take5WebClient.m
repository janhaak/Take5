//
//  Take5WebClient.m
//  Take5
//
//  Created by Scott Gerring on 21/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Take5WebClient.h"

@implementation Take5WebClient

static NSString* Hostname = @"http://evening-dusk-5462.heroku.com/";
static NSString* TemplatesURL = @"templates/";
static NSString* FetchTemplateURL = @"template/";

- (NSDictionary *)fetchJSON:(NSURL *)FetchAllTemplates
{
    NSURLRequest* fetchTemplatesReq = [[NSURLRequest alloc] initWithURL:FetchAllTemplates];
	NSURLResponse* urlResponse;
	NSError* urlError;
	NSData* data = [NSURLConnection sendSynchronousRequest:fetchTemplatesReq returningResponse:&urlResponse error:&urlError];
	
	NSError* error;
	NSDictionary* templatesObj = [NSJSONSerialization JSONObjectWithData:data options:nil error:&error];
    return templatesObj;
}

- (NSArray*)fetchTemplateNames
{
	NSURL* FetchAllTemplates = [[NSURL alloc] initWithString:[Hostname stringByAppendingFormat:TemplatesURL]];
	
	NSDictionary *templatesObj;
    templatesObj = [self fetchJSON:FetchAllTemplates];
	NSArray* templateNames = [templatesObj valueForKey:@"templates"];
		
	return templateNames;
}

-(NSDictionary*)fetchTemplate:(NSString*)name
{
	NSURL* fetchTemplate = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",Hostname,FetchTemplateURL,name]];
	return [self fetchJSON:fetchTemplate];
}

	
- (BOOL)submitTemplate:(NSString*)template forUser:(NSString*)user withPassword:(NSString*)password
{
	return FALSE;
}

@end
