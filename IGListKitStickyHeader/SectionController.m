//
//  SectionController.m
//  IGListKitStickyHeader
//
//  Created by Marcus Wu on 2017/7/28.
//  Copyright © 2017年 MarcusWu. All rights reserved.
//

#import "SectionController.h"
#import "MyCollectionViewCell.h"
#import "ViewModel.h"

@interface SectionController () <IGListSupplementaryViewSource>

@property (nonatomic, strong) ViewModel *viewModel;

@end

@implementation SectionController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.supplementaryViewSource = self;
    }
    
    return self;
}

#pragma mark - IGListSupplementaryViewSource

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
    UICollectionReusableView *view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                               forSectionController:self
                                                                                            nibName:@"StickyHeaderView"
                                                                                             bundle:nil
                                                                                            atIndex:index];
    
    view.backgroundColor = [UIColor redColor];
    
    return view;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 44);
}

#pragma mark -

- (NSInteger)numberOfItems {
    return self.viewModel.dataArray.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 80);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    MyCollectionViewCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"MyCollectionViewCell"
                                                                                 bundle:nil
                                                                   forSectionController:self
                                                                                atIndex:index];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.label.text = self.viewModel.dataArray[index];
    
    return cell;
}

- (void)didUpdateToObject:(id)object {
    self.viewModel = object;
}

@end
