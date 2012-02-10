//
//  FarosAppDelegate.h
//  Faros
//
//  Created by Andreas Wassmer on 08.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FileTableSource.h"
#import "MainTabView.h"
#import "MeanImage.h"
#import "EigenimageHandler.h"
#import "Decompositor.h"


@interface FarosAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet FileTableSource *tblSource;
	IBOutlet MainTabView *mTabView;
	
	EigenimageHandler *imgHandler;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) loadFileButtonPressed:(id)sender;
- (IBAction) calculateButtonPressed:(id)sender;
- (IBAction) sliderChangedValue:(id)sender;
@end
