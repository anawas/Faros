//
//  MeanImage.m
//  Faros
//
//  Created by Andreas Wassmer on 15.12.10.
//  Copyright 2010 phandroo.com. All rights reserved.
//

#import "MeanImage.h"

@interface MeanImage (private)
- (NSUInteger)meanPixelValueAtX:(NSUInteger)x y:(NSUInteger)y;
@end


@implementation MeanImage

- (id)initWithImage:(NSImage *)imageTemplate {
	
	self = [super initWithData:[imageTemplate TIFFRepresentation]];
	selfRep = [[self representations] objectAtIndex:0];

	NSSize __size = [self size];
	nx = (NSUInteger)__size.width;
	ny = (NSUInteger)__size.height;
	
	return self;
}

- (void)dealloc {
	[super dealloc];
}

- (void)calculateMeanImageOfArray:(NSArray *)imageArray {
	NSUInteger pixelData[2];
	int x, y;
	pixelData[0] = 0;
	pixelData[1] = 255;
	
	_imageArray = imageArray;
	
	for (y = 0; y < ny; y++) {
		for (x= 0; x < nx; x++) {
			pixelData[0] = [self meanPixelValueAtX:x y:y];
			[selfRep setPixel:pixelData atX:x y:y];
		}
	}
}
@end

@implementation MeanImage (private) 
- (NSUInteger)meanPixelValueAtX:(NSUInteger)x y:(NSUInteger)y {
	NSUInteger pixelData[2];
	NSUInteger retVal = 0;
	
	for (NSImage *img in _imageArray) {
		NSBitmapImageRep *rep = [[img representations] objectAtIndex:0];
		[rep getPixel:pixelData atX:x y:y];
		retVal += pixelData[0];
	}
		
	retVal /= [_imageArray count];
	return retVal;
}
@end
