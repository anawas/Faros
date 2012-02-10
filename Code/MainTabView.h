//
//  MainTabView.h
//
//  Created by Andreas Wassmer on 08.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TrainingTabView.h"
#import "RecognitionTabView.h"

@interface MainTabView : NSTabView {
	IBOutlet TrainingTabView *trainingTab;
	IBOutlet RecognitionTabView *recognTab;
}

- (void)setMeanfaceImage:(NSImage *)image;
- (void)setEigenfaceImage:(NSImage *)image;
- (void)setSliderMaxImages:(NSNumber *)maxVal;
- (void)setSliderTicks:(NSInteger)numOfTicks;
@end
