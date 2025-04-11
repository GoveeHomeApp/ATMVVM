#import "ATMVVM_Table_ListVM.h"

@interface ATMVVM_Table_ListVM()
@property (nonatomic, strong) ATMVVM_Table_Proxy * viewProxy;
@property (nonatomic, assign) ATMVVMState state;
@property (nonatomic, weak, nullable) UITableView * tableView;
@end

@implementation ATMVVM_Table_ListVM

- (instancetype)init{
    self = [super init];
    if (self) {
        self.viewProxy = [[ATMVVM_Table_Proxy alloc] init];
        [self setupData];
    }
    return self;
}

- (instancetype)initWithViewProxy:(ATMVVM_Table_Proxy *)viewProxy{
    self = [super init];
    if (self) {
        self.viewProxy = viewProxy;
        [self setupData];
    }
    return self;
}

- (void)setupData {}
- (void)createData {}
- (void)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
- (void)registerTableView:(nonnull UITableView *)tableView{
    self.tableView = tableView;
}
- (void)didChangeState:(ATMVVMState)state flag:(NSInteger)flag msg:(NSString *)msg err:(NSError *)err {
    self.state = state;
    if(self.delegate && [self.delegate respondsToSelector:@selector(didChangeState:flag:msg:err:)]){
        [self.delegate didChangeState:state flag:flag msg:msg err:err];
    }
}

@end
