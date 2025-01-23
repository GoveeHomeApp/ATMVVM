#import <Foundation/Foundation.h>
#import "ATMVVMDefine.h"
#import "ATMVVM_Table_Proxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATMVVM_Table_ListVM : NSObject<ATMVVM_ListState_Delegate>
@property (nonatomic, weak) id<ATMVVM_ListState_Delegate> delegate;

@property (nonatomic, strong, readonly) ATMVVM_Table_Proxy * viewProxy;
@property (nonatomic, assign, readonly) ATMVVMState state;
- (instancetype)initWithViewProxy:(ATMVVM_Table_Proxy *)viewProxy;
- (void)setupData; //初始化数据 - 初始化Dict,Array ==
- (void)createData; //手动创建数据 - 给Dict,Array赋值数据 ==
- (void)reloadData; //刷新数据/重新创建数据 - 刷新界面

- (void)registerTableView:(nonnull UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
