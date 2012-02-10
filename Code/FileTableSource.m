//
//  FileTableSource.m
//  Faros
//
//  Created by Andreas Wassmer on 09.12.10.
//  Copyright 2010 phandroo.com. All rights reserved.
//

#import "FileTableSource.h"


@implementation FileTableSource

- (void)awakeFromNib {
	fileList = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)dealloc {
	[fileList release];
	[super dealloc];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
	return [fileList count];
}
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	return [[fileList objectAtIndex:rowIndex] lastPathComponent];
}

- (void)addFile:(NSURL *) fileUrl {
	[fileList addObject:fileUrl];
	[myTable reloadData];
}

- (void)addFiles:(NSArray *)filesArray keepOld:(BOOL)flag {
	if (!flag) {
		[fileList removeAllObjects];
	}
	[fileList addObjectsFromArray:filesArray];
	[myTable reloadData];
}

- (NSArray *)getFiles {
	return fileList;
}
@end
