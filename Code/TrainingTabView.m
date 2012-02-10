//
//  TrainingTabView.m
//
//  Created by Andreas Obrist on 14.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrainingTabView.h"

@implementation TrainingTabView
@synthesize meanfaceImageView;
@synthesize eigenfaceImageView;
@synthesize eigenfaceSlider;

- (void)awakeFromNib {

	[eigenfaceSlider setMaxValue:1.0];
	[eigenfaceSlider setMinValue:1.0];
	[eigenfaceSlider setFloatValue: 1.0];
	NSLog(@"eigenfaceSlider = %@", eigenfaceSlider);

}
@end
