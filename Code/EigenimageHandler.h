//
//  EigenimageHandler.h
//  Faros
//
//  Created by Andreas Wassmer on 16.12.10.
//  Copyright 2010 phandroo.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface EigenimageHandler : NSObject {
	NSMutableArray *eigenimages;
	NSImage *_imageTemplate;
	NSUInteger nx, ny;
	NSUInteger numOfImages;
}

- (id)initWithImage:(NSImage *)imageTemplate;
- (void)dealloc;
- (void)addEigenimageWithData:(NSData *)imgData;
- (void)addEigenimageWithNumberArray:(NSArray *)dataarray;
- (NSImage *)getImageWithNumber:(NSUInteger)number;
- (NSUInteger)count;
@end
