//
//  Compositor.m
//  Faros
//
//  Created by Andreas Wassmer on 21.12.10.
//  Copyright 2010 phandroo.com. All rights reserved.
//

#import "Decompositor.h"


@implementation Decompositor

@synthesize numOfEigenvalues;

- (id)init {
	self = [super init];
	
	if (self) {
		columns = 0;
		rows = 0;
		numOfEigenvalues = 0;
		eigenValues = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return self;
}

- (void)dealloc {
	if (eigenValues) {
		[eigenValues release];
		eigenValues = nil;
	}
	
	gsl_matrix_free(M);
	
	[super dealloc];
}

- (void)createMatrix:(NSArray *)imageArray {
	int j;
	int x, y;
	NSUInteger counter;
	NSUInteger pixel[2];
	NSUInteger nx, ny;
	NSBitmapImageRep *rep;
	
	columns = [imageArray count];
	
	NSImage *testImg = [imageArray objectAtIndex:0];
	NSSize __size = [testImg size];
	
	nx = (NSUInteger)__size.width;
	ny = (NSUInteger)__size.height;
	
	rows = nx * ny;

	M = gsl_matrix_alloc(rows, columns);
	
	if (M == nil) {
		NSLog(@"ERROR -- Cannot allocate memory for matrix");
		return;
	}	
	
	NSUInteger _stride;
	
	for (j = 0; j < columns; j++) {
		gsl_vector_view col = gsl_matrix_column(M, j);		
		_stride = col.vector.stride;
		rep = [[[imageArray objectAtIndex:j] representations] objectAtIndex:0];
		counter = 0;
		for (y = 0; y < ny; y++) {
			for (x = 0; x < nx; x++) {
				[rep getPixel:pixel atX:x y:y];
				col.vector.data[_stride*counter] = (double)pixel[0]/255.0;
				++counter;
			}
		}
		NSAssert(counter == rows, @"counter did not run far enough", @"n");		
	}	
}

- (void)doDecomposition {

	if (M == nil) {
		NSLog(@"ERROR -- Matrix M not set!\nUse createMatrix: first.");
		return;
	}

	gsl_matrix *V = gsl_matrix_alloc(columns, columns);
	gsl_vector *S = gsl_vector_alloc(columns);
	gsl_vector *workspace = gsl_vector_alloc(columns);
	
	int res = gsl_linalg_SV_decomp(M, V, S, workspace);
	if (res) {
		NSLog(@"ERROR -- %s", gsl_strerror(res));
		gsl_matrix_free(V);
		gsl_vector_free(S);
		gsl_vector_free(workspace);
		return;
	}
	
	// Could do this "on demand", i.e. if eigenvalues are requested. But I want
	// to clean up gsl stuff after use.
	int i;
	for (i = 0; i < columns; i++) {
		[eigenValues addObject:[NSNumber numberWithDouble:S->data[i]]];
	}
	
	numOfEigenvalues = columns;
	
	gsl_matrix_free(V);
	gsl_vector_free(S);
	gsl_vector_free(workspace);
}

- (NSArray *)eigenvectorWithIndex:(NSUInteger)index {
	
	NSMutableArray *colVector = [NSMutableArray arrayWithCapacity:rows];
	if ((index <0) || (index >= columns)) {
		return nil;
	}
	
	gsl_vector *col = gsl_vector_alloc(rows);
	gsl_matrix_get_col(col, M, index);

	int i;
	
	for (i = 0; i < rows; i++) {
		[colVector addObject:[NSNumber numberWithDouble:col->data[i]]];
	}
	gsl_vector_free(col);
	
	return (NSArray *)colVector;
}

- (NSArray *)eigenvalues {
	return (NSArray *)eigenValues;
}

@end
