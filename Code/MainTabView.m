//
//  MainTabView.m
//
//  Created by Andreas Wassmer on 08.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainTabView.h"

@implementation MainTabView

- (void)awakeFromNib {
	NSLog(@"MainTabView awoken from Nib");
	NSLog(@"TabViewItems = %@", [self tabViewItems]);
	
}

- (void)dealloc {
	[super dealloc];
}

- (void)setMeanfaceImage:(NSImage *)image {
	[[trainingTab meanfaceImageView] setImage:image];
}

- (void)setEigenfaceImage:(NSImage *)image {
	[[trainingTab eigenfaceImageView] setImage:image];
}

- (void)setSliderMaxImages:(NSNumber *)maxVal {
	[[trainingTab eigenfaceSlider] setMaxValue:[maxVal doubleValue]];
}

- (void)setSliderTicks:(NSInteger)numOfTicks {
	[[trainingTab eigenfaceSlider] setNumberOfTickMarks:numOfTicks];

}

@end

