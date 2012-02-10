//
//  FileTableSource.h
//  Faros
//
//  Created by Andreas Wassmer on 09.12.10.
//  Copyright 2010 phandroo.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FileTableSource : NSObject {
	NSMutableArray *fileList;
	IBOutlet NSTableView *myTable;
}

- (void)awakeFromNib;
- (void)dealloc;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView;
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex;

- (void)addFile:(NSURL *) fileUrl;
- (void)addFiles:(NSArray *)filesArray keepOld:(BOOL)flag;
- (NSArray *)getFiles;

@end
