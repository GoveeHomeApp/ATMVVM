#import <UIKit/UIKit.h>
#import "ATMVVM_Table_Proxy.h"
#import "ATMVVM_Table_ListVM.h"
NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ATMVVM)

- (void)setupListVM:(ATMVVM_Table_ListVM *)listVM;
- (void)setupWithViewProxy:(ATMVVM_Table_Proxy *)viewProxy;

@end

NS_ASSUME_NONNULL_END
