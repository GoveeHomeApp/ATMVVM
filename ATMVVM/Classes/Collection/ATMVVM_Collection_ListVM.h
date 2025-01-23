#import <Foundation/Foundation.h>
#import "ATMVVMDefine.h"
#import "ATMVVM_Collection_Proxy.h"
#ifndef ATMVVM_Collection_ListVM_h
#define ATMVVM_Collection_ListVM_h

@interface ATMVVM_Collection_ListVM : NSObject<ATMVVM_ListState_Delegate>
@property (nonatomic, weak, nullable) id<ATMVVM_ListState_Delegate> delegate;

@property (nonatomic, strong, readonly, nonnull) ATMVVM_Collection_Proxy * viewProxy;
@property (nonatomic, assign, readonly) ATMVVMState state;
- (nonnull instancetype)initWithViewProxy:(nonnull ATMVVM_Collection_Proxy *)viewProxy;
- (void)setupData; //初始化数据 - 初始化Dict,Array ==
- (void)createData; //手动创建数据 - 给Dict,Array赋值数据 ==
- (void)reloadData; //刷新数据/重新创建数据 - 刷新界面

- (void)registerCollectionView:(nonnull UICollectionView *)collectionView;

@end

#endif
