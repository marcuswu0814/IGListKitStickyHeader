//
//  ViewModel.m
//  IGListKitStickyHeader
//
//  Created by Marcus Wu on 2017/7/28.
//  Copyright © 2017年 MarcusWu. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        for (int i = 0; i < 30; ++i) {
            [_dataArray addObject:[NSString stringWithFormat:@"%@", @(i)]];
        }
    }
    
    return _dataArray;
}

#pragma mark - IGListDiffable

- (nonnull id <NSObject>)diffIdentifier {
    return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
    return self == other;
}

- (void)appendTestData {
    NSInteger count = self.dataArray.count;
    
    [self.dataArray addObject:[NSString stringWithFormat:@"%@", @(count)]];
    
    [self dataDidChanged];
}

- (void)removeTestData {
    [self.dataArray removeLastObject];
    
    [self dataDidChanged];
}

- (void)dataDidChanged {
    if ([self.dalegate respondsToSelector:@selector(dataDidChanged)]) {
        [self.dalegate dataDidChanged];
    }
}

@end
