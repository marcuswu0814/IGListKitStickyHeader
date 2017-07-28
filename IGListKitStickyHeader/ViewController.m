//
//  ViewController.m
//  IGListKitStickyHeader
//
//  Created by Marcus Wu on 2017/7/28.
//  Copyright © 2017年 MarcusWu. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "SectionController.h"

#import <IGListKit/IGListKit.h>

@interface ViewController () <IGListAdapterDataSource, ViewModelDelegate>

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) ViewModel *viewModel;

@property (nonatomic, strong) IGListAdapter *adapter;

@end

@implementation ViewController


- (NSArray *)data {
    if (!_data) {
        _data = @[self.viewModel];
    }
    
    return _data;
}


- (ViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [ViewModel new];
        _viewModel.dalegate = self;
    }
    
    return _viewModel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[[IGListCollectionViewLayout alloc] initWithStickyHeaders:YES
                                                                                                            topContentInset:64.f
                                                                                                              stretchToEdge:YES]];
    }
    
    return _collectionView;
}

- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self];
        _adapter.dataSource = self;
        _adapter.collectionView = self.collectionView;
    }
    
    return _adapter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(remove)];
    
    [self.adapter performUpdatesAnimated:YES completion:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - Action

- (void)add {
    [self.viewModel appendTestData];
}

- (void)remove {
    [self.viewModel removeTestData];
}

#pragma mark - ViewModelDelegate

- (void)dataDidChanged {
    [self.adapter reloadDataWithCompletion:nil];
}

#pragma mark - IGListAdapterDataSource

- (nullable UIView *)emptyViewForListAdapter:(nonnull IGListAdapter *)listAdapter {
    return nil;
}

- (nonnull IGListSectionController *)listAdapter:(nonnull IGListAdapter *)listAdapter sectionControllerForObject:(nonnull id)object {
    return [[SectionController alloc] init];
}

- (nonnull NSArray<id<IGListDiffable>> *)objectsForListAdapter:(nonnull IGListAdapter *)listAdapter {
    return self.data;
}

@end
