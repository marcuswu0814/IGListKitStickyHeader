//
//  ViewModel.h
//  IGListKitStickyHeader
//
//  Created by Marcus Wu on 2017/7/28.
//  Copyright © 2017年 MarcusWu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <IGListKit/IGListDiffable.h>

@class ViewModel;

@protocol ViewModelDelegate <NSObject>

- (void)dataDidChanged;

@end

@interface ViewModel : NSObject <IGListDiffable>

@property (nonatomic, weak) id <ViewModelDelegate> dalegate;

@property (nonatomic, copy) NSMutableArray *dataArray;

- (void)appendTestData;

- (void)removeTestData;

@end
