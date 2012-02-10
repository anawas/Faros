//
//  MeanImage.h
//  Faros
//
//  Created by Andreas Wassmer on 15.12.10.
//  Copyright 2010 phandroo.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MeanImage : NSImage {
	NSBitmapImageRep *selfRep;
	NSUInteger nx, ny;
	NSArray *_imageArray;
}

- (id)initWithImage:(NSImage *)imageTemplate;
- (void)dealloc;

- (void)calculateMeanImageOfArray:(NSArray *)imageArray;

@end
