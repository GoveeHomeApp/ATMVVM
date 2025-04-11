#import "ATMVVM_Table_RowVM.h"
#import "ATMVVM_Table_Cell.h"

@interface ATMVVM_Table_RowVM()

@property (nonatomic, copy) ATMVVM_Table_RowVM_ReloadViewBlock _Nonnull reloadViewBlock;
@property (nonatomic, copy) ATMVVM_Table_RowVM_RefreshViewBlock _Nonnull refreshViewBlock;

@end

@implementation ATMVVM_Table_RowVM

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
    self.rowHeight = CGFLOAT_MIN;
    self.reloadViewBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    };
    self.refreshViewBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView * tableView = weakSelf.tableView;
            NSIndexPath * indexPath = weakSelf.indexPath;
            
            if(tableView && indexPath) {
                ATMVVM_Table_Cell * cell = (ATMVVM_Table_Cell *)[tableView cellForRowAtIndexPath:indexPath];
                if(cell){
                    [cell refreshSubviews:YES];
                    [cell layoutIfNeeded];
                }
            }
        });
    };
}

- (void)setupData{
    
}

- (void)createLayout{
    
}

@end
