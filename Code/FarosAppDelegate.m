//
//  FarosAppDelegate.m
//  Faros
//
//  Created by Andreas Wassmer on 08.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FarosAppDelegate.h"

@implementation FarosAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (IBAction) loadFileButtonPressed:(id)sender {
	NSLog(@"select file button pressed");

	NSOpenPanel *op = [NSOpenPanel openPanel];
	[op setCanChooseFiles:YES];
	[op setAllowsMultipleSelection:YES];
	[op setAllowedFileTypes:[NSArray arrayWithObject:@"png"]];
	
	[op beginSheetModalForWindow:[self window] 
			   completionHandler:^(NSInteger result) {
				   if (NSFileHandlingPanelOKButton) {
					   [tblSource addFiles:[op URLs] keepOld:NO];
				   };
			   }];
}

- (void)dealloc {
	[imgHandler release];
	[super dealloc];

}

- (IBAction) calculateButtonPressed:(id)sender {
	NSLog(@"calculate button pressed");
	NSMutableArray *imgArray = [NSMutableArray arrayWithCapacity:10];
	
	NSArray *imgToProcess = [tblSource getFiles];

	for (NSURL *url in imgToProcess) {
		NSImage *img = [[NSImage alloc] initWithContentsOfURL:url];
		[imgArray addObject:img];
		[img release];
	}
	MeanImage *meanImg = [[MeanImage alloc] initWithImage:[imgArray objectAtIndex:0]];	
	[meanImg calculateMeanImageOfArray:imgArray];
	
	[mTabView setMeanfaceImage:meanImg];
	
	Decompositor *decomp = [[Decompositor alloc] init];
	[decomp createMatrix:imgArray];
	[decomp doDecomposition];
	
	[mTabView setSliderMaxImages:[NSNumber numberWithUnsignedInt:[decomp numOfEigenvalues]]];
	[mTabView setSliderTicks:[decomp numOfEigenvalues]];

	imgHandler = [[EigenimageHandler alloc] initWithImage:[imgArray objectAtIndex:0]];
	
	int i;
	for (i = 0; i < [decomp numOfEigenvalues]; i++) {
		NSArray *eigenVec = [decomp eigenvectorWithIndex:i];
		[imgHandler addEigenimageWithNumberArray:eigenVec];		
	}
	[mTabView setEigenfaceImage:[imgHandler getImageWithNumber:0]];
		 
	[decomp release];
	[meanImg release];
}


- (IBAction) sliderChangedValue:(id)sender {
	NSUInteger imgToDisplay;
	
	NSSlider *slider = (NSSlider *)sender;
	NSLog(@"eigenfaceSlider changed value to : %d", [slider intValue]);
	imgToDisplay = [slider intValue];
	[mTabView setEigenfaceImage:[imgHandler getImageWithNumber:imgToDisplay-1]];
}


@end
