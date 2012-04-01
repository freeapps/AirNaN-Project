//
//  Track.h
//  AIRNAN
//
//  Created by class10_user on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SEPARATOR @"="
#define ENDOFLINE @"\n"

@interface Track : NSObject {
    
    NSString* trackName;
    NSString* trackType;
    NSString* trackFile;
    NSString* trackLink;
    
}

@property (nonatomic, retain) NSString* trackName;
@property (nonatomic, retain) NSString* trackType;
@property (nonatomic, retain) NSString* trackFile;
@property (nonatomic, retain) NSString* trackLink;

-(id) initWithRow:(NSString*) sRow;

@end
