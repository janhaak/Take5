//
//  Take5WebClient.h
//  Take5
//
//  Created by Scott Gerring on 21/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Take5WebClient : NSObject <NSURLConnectionDelegate>
	
-(NSArray*)fetchTemplateNames;
-(NSDictionary*)fetchTemplate:(NSString*)name;

-(BOOL)submitTemplate:(NSString*)template forUser:(NSString*)user withPassword:(NSString*)password;
	
@end
