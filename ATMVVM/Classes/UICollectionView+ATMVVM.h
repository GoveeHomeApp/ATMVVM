#import <UIKit/UIKit.h>
#import "ATMVVM_Collection_Proxy.h"
#import "ATMVVM_Collection_ListVM.h"

@interface UICollectionView(ATMVVM)

- (void)setupListVM:(ATMVVM_Collection_ListVM *)listVM;
- (void)setupWithViewProxy:(ATMVVM_Collection_Proxy *)viewProxy;

@end
