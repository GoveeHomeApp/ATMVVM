#import "ATMVVM_Table_SectionVM.h"
#import "ATMVVM_Table_HeaderFooterView.h"
@interface ATMVVM_Table_SectionVM()

@property (nonatomic, copy) ATMVVM_Table_SectionVM_ReloadViewBlock _Nonnull reloadViewBlock;
@property (nonatomic, copy) ATMVVM_Table_SectionVM_RefreshViewBlock _Nonnull refreshHeaderViewBlock;
@property (nonatomic, copy) ATMVVM_Table_SectionVM_RefreshViewBlock _Nonnull refreshFooterViewBlock;

@end

@implementation ATMVVM_Table_SectionVM

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
    self.headerHeight = CGFLOAT_MIN;
    self.footerHeight = CGFLOAT_MIN;
    
    self.reloadViewBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    };
    self.refreshHeaderViewBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView * tableView = weakSelf.tableView;
            NSIndexPath * indexPath = weakSelf.indexPath;
            
            if(tableView && indexPath) {
                ATMVVM_Table_HeaderFooterView * header = (ATMVVM_Table_HeaderFooterView *)[tableView headerViewForSection:indexPath.section];
                if(header){
                    [header refreshSubviews:YES];
                    [header layoutIfNeeded];
                }
            }
        });
    };
    self.refreshFooterViewBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView * tableView = weakSelf.tableView;
            NSIndexPath * indexPath = weakSelf.indexPath;
            
            if(tableView && indexPath) {
                ATMVVM_Table_HeaderFooterView * footer = (ATMVVM_Table_HeaderFooterView *)[tableView footerViewForSection:indexPath.section];
                if(footer){
                    [footer refreshSubviews:YES];
                    [footer layoutIfNeeded];
                }
            }
        });
    };
}

- (void)setupData{
    
}

- (void)createLayout{
    
}

- (NSMutableArray<ATMVVM_Table_RowVM *> *)rowVMs{
    if(!_rowVMs){
        _rowVMs = [NSMutableArray new];
    }
    return _rowVMs;
}

@end
