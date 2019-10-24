//
//  DirectoryDataSource.m
//  TableViewNavigation
//
//  Created by Aleksandr on 19/10/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "DirectoryDataSource.h"
#import "DirectoryCell.h"
#import "FileCell.h"

@interface DirectoryDataSource()

@property (strong, nonatomic) NSArray *contents;
@property (strong, nonatomic) NSString *selectedPath;

@end

@implementation DirectoryDataSource

- (instancetype)initWithFolderPath:(NSString *)path
{
    self = [super init];
    if (self) {
        self.selectedPath = path;
    }
    return self;
}

- (NSString *)selectedPath {
    return _selectedPath;
}

- (void)refreshContent {
    NSArray *contents = [[NSFileManager defaultManager]
                         contentsOfDirectoryAtPath:self.selectedPath
                         error:nil];
    self.contents = [self filterAndSortContents:contents];
}

- (NSArray *)filterAndSortContents:(NSArray *)contents {
    NSMutableArray *foldersArray = [NSMutableArray array];
    NSMutableArray *filesArray = [NSMutableArray array];
    for (NSString *content in contents) {
        NSString *filePath = [self.selectedPath stringByAppendingPathComponent:content];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        BOOL isDirectory = NO;;
        [fm fileExistsAtPath:filePath isDirectory:&isDirectory];
        NSDictionary *attributes = [fm attributesOfItemAtPath:filePath
                                    error:nil];
        if ([attributes fileExtensionHidden]) {
            continue;
        }
        
        if (isDirectory) {
            [foldersArray addObject:content];
        } else {
            [filesArray addObject:content];
        }
    }
    
    [foldersArray sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    [filesArray sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
    }];
    NSArray *result = [foldersArray arrayByAddingObjectsFromArray:filesArray];
    return result;
}

- (BOOL)isDirectoryAtIndexPath:(NSIndexPath *)indexPath {
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    NSString *filePath = [self.selectedPath stringByAppendingPathComponent:fileName];
    
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

- (NSString *)directoryNameAtIndexPath:(NSIndexPath *)indexPath {
    return [self.contents objectAtIndex:indexPath.row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
        DirectoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DirectoryCell class])];
        
        unsigned long long folderSize = [self calculateFolderSize:[self.selectedPath stringByAppendingPathComponent:fileName]];
        
        [cell configureWothFolder:fileName size:folderSize];
        
        return cell;
        
    } else {
        
        FileCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FileCell class])];
        
        NSString *path = [self.selectedPath stringByAppendingPathComponent:fileName];
        NSDictionary *attributes = [[NSFileManager defaultManager]
                                    attributesOfItemAtPath:path
                                    error:nil];
        
        [cell configureWithFile:fileName
                           size:[attributes fileSize]
                           date:[attributes fileModificationDate]];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - Utility

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[NSFileManager defaultManager] removeItemAtPath:[self.selectedPath stringByAppendingPathComponent:self.contents[indexPath.row]]
                                                   error:nil];
        
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self refreshContent];
        [tableView endUpdates];
    }
}

- (unsigned long long)calculateFolderSize:(NSString *)path {
    NSArray *contents = [[NSFileManager defaultManager]
     contentsOfDirectoryAtPath:path
     error:nil];
    
    unsigned long long size = 0;
    
    for (NSString *content in contents) {
        NSString *filePath = [path stringByAppendingPathComponent:content];
        BOOL isDirectory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if (isDirectory) {
            size = size + [self calculateFolderSize:filePath];
        } else {
            NSDictionary *attributes = [[NSFileManager defaultManager]
                                        attributesOfItemAtPath:filePath
                                        error:nil];
            size = size + [attributes fileSize];
        }
    }
    return size;
}

@end
