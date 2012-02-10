//
//  EigenimageHandler.m
//  Faros
//
//  Created by Andreas Wassmer on 16.12.10.
//  Copyright 2010 phandroo.com. All rights reserved.
//

#import "EigenimageHandler.h"

typedef struct {
	float min;
	float max;
} MinMax;

@interface EigenimageHandler (private)
- (MinMax)findMinMaxOfArray:(NSArray *)array;
@end

@implementation EigenimageHandler

- (id)initWithImage:(NSImage *)imageTemplate {
	self = [super init];
	_imageTemplate = [[NSImage alloc] initWithData:[imageTemplate TIFFRepresentation]];
	
	NSSize __size = [_imageTemplate size];
	nx = (NSUInteger)__size.width;
	ny = (NSUInteger)__size.height;
	
	eigenimages = [[NSMutableArray alloc] initWithCapacity:10];
	
	return self;
}

- (void)dealloc {
	[_imageTemplate release];
	[eigenimages release];
	[super dealloc];
}

- (NSUInteger)count {
	return numOfImages;
}

- (void)addEigenimageWithData:(NSData *)imgData {
	unsigned char *imgBuffer, *dataBuffer;
	
	NSImage *newImage = [[NSImage alloc] initWithData:[_imageTemplate TIFFRepresentation]];
	NSBitmapImageRep *rep = [[newImage representations] objectAtIndex:0];
	
	imgBuffer = [rep bitmapData];
	dataBuffer = (unsigned char *)[imgData bytes];
	memcpy(imgBuffer, dataBuffer, [imgData length]);
	[eigenimages addObject:newImage];
	[newImage release];
	numOfImages = [eigenimages count];
}

- (void)addEigenimageWithNumberArray:(NSArray *)dataarray {
	NSUInteger pixel[2];
	float stretch;
	NSUInteger count;
	int x, y;
	
	pixel[0] = 0;
	pixel[1] = 255;
	
	MinMax minmax = [self findMinMaxOfArray:dataarray];
	stretch = 255.0f / (minmax.max - minmax.min);
	
	NSImage *newImage = [[NSImage alloc] initWithData:[_imageTemplate TIFFRepresentation]];
	NSBitmapImageRep *rep = [[newImage representations] objectAtIndex:0];
	
	float val;
	count = 0;
	for (y = 0; y < ny; y++) {
		for (x = 0; x < nx; x++) {
			val = [[dataarray objectAtIndex:count++] floatValue];
			pixel[0] = (NSUInteger)((val - minmax.min) * stretch);
			[rep setPixel:pixel atX:x y:y];
		}
	}

	[eigenimages addObject:newImage];
	[newImage release];
	numOfImages = [eigenimages count];	
}


- (NSImage *)getImageWithNumber:(NSUInteger)number {
	if (number >= numOfImages) {
		return nil;
	}
	
	return [eigenimages objectAtIndex:number];
}
@end

@implementation EigenimageHandler (private)
- (MinMax)findMinMaxOfArray:(NSArray *)array {
	MinMax mStruct;
	float val;
	
	mStruct.min = MAXFLOAT;
	mStruct.max = -MAXFLOAT;

	for (NSNumber *num in array) {
		val = [num floatValue];
		if (val >= mStruct.max) {
			mStruct.max = val;
		}

		if (val <= mStruct.min) {
			mStruct.min = val;
		}		
	}
	
	return mStruct;
}
@end
