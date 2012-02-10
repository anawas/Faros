//
//  TrainingTabView.h
//
//  Created by Andreas Obrist on 14.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TrainingTabView : NSTabViewItem {
  IBOutlet NSResponder *initialFirstResponder;
	IBOutlet NSSlider *eigenfaceSlider;
	IBOutlet NSImageView *meanfaceImageView;
	IBOutlet NSImageView *eigenfaceImageView;

}
@property (assign, readwrite)NSImageView *meanfaceImageView;
@property (assign, readwrite)NSImageView *eigenfaceImageView;
@property (assign) NSSlider *eigenfaceSlider;
@end
