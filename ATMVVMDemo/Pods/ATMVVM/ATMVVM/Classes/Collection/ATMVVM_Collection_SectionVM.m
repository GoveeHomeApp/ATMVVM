#import "ATMVVM_Collection_SectionVM.h"
#import "ATMVVM_Collection_ReusableView.h"

@interface ATMVVM_Collection_SectionVM()

@property (nonatomic, copy) ATMVVM_Collection_SectionVM_ReloadSectionBlock _Nonnull reloadSectionBlock;
@property (nonatomic, copy) ATMVVM_Collection_SectionVM_ReloadViewBlock _Nonnull reloadViewBlock;
@property (nonatomic, copy) ATMVVM_Collection_SectionVM_RefreshViewBlock _Nonnull refreshHeaderViewBlock;
@property (nonatomic, copy) ATMVVM_Collection_SectionVM_RefreshViewBlock _Nonnull refreshFooterViewBlock;

@end

@implementation ATMVVM_Collection_SectionVM

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _setupBlocks];
        [self setupData];
    }
    return self;
}

- (void)_setupBlocks{
    __weak typeof(self) weakSelf = self;
    self.reloadSectionBlock = ^{
        NSInteger section = weakSelf.indexPath.section;
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView performWithoutAnimation:^{
                [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
            }];
        });
    };
    self.reloadViewBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    };
    self.refreshHeaderViewBlock = ^{
        void (^block)(void) = ^{
            UICollectionView * collectionView = weakSelf.collectionView;
            NSIndexPath * indexPath = weakSelf.indexPath;
            
            if(collectionView && indexPath) {
                ATMVVM_Collection_ReusableView * header = (ATMVVM_Collection_ReusableView *)[collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
                if(header){
                    [header refreshSubviews:YES];
                    [header layoutIfNeeded];
                }
            }
        };
        
        if(!NSThread.isMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }else{
            block();
        }
    };
    self.refreshFooterViewBlock = ^{
        void (^block)(void) = ^{
            UICollectionView * collectionView = weakSelf.collectionView;
            NSIndexPath * indexPath = weakSelf.indexPath;
            
            if(collectionView && indexPath) {
                ATMVVM_Collection_ReusableView * footer = (ATMVVM_Collection_ReusableView *)[collectionView supplementaryViewForElementKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
                if(footer){
                    [footer refreshSubviews:YES];
                    [footer layoutIfNeeded];
                }
            }
        };
        
        if(!NSThread.isMainThread){
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }else{
            block();
        }
    };
}

- (void)setupData{
    
}

- (void)createLayout{
    
}

- (NSMutableArray<ATMVVM_Collection_ItemVM *> *)itemVMs{
    if(!_itemVMs){
        _itemVMs = [NSMutableArray new];
    }
    return _itemVMs;
}

@end
