//
//  Compositor.h
//  Faros
//
//  Created by Andreas Wassmer on 21.12.10.
//  Copyright 2010 phandroo.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "gsl/gsl_matrix.h"
#import "gsl/gsl_linalg.h"

@interface Decompositor : NSObject {
	NSUInteger rows, columns;
	NSUInteger numOfEigenvalues;
	NSMutableArray *eigenValues;
	
	gsl_matrix *M;
}

@property NSUInteger numOfEigenvalues;

- (void)createMatrix:(NSArray *)imageArray;
- (void)doDecomposition;
- (NSArray *)eigenvectorWithIndex:(NSUInteger)index;
- (NSArray *)eigenvalues;
@end
