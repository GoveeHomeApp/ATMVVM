#import <Foundation/Foundation.h>

#ifndef ATMVVM_Collection_ItemVM_h
#define ATMVVM_Collection_ItemVM_h

@class ATMVVM_Collection_ItemVM;
typedef void (^ATMVVM_Collection_ItemVM_ReloadSectionBlock)(void);
typedef void (^ATMVVM_Collection_ItemVM_ReloadViewBlock)(void);
typedef void (^ATMVVM_Collection_ItemVM_RefreshViewBlock)(void);
typedef void (^ATMVVM_Collection_ItemVM_DidSelectItemBlock)(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, ATMVVM_Collection_ItemVM * _Nonnull itemVM);


@interface ATMVVM_Collection_ItemVM : NSObject

//这几个属性不能自己赋值使用
@property (nonatomic, copy, readonly) ATMVVM_Collection_ItemVM_ReloadSectionBlock _Nonnull reloadSectionBlock;
@property (nonatomic, copy, readonly) ATMVVM_Collection_ItemVM_ReloadViewBlock _Nonnull reloadViewBlock;
@property (nonatomic, copy, readonly) ATMVVM_Collection_ItemVM_RefreshViewBlock _Nonnull refreshViewBlock;

@property (nonatomic, weak) UICollectionView * _Nullable collectionView;
@property (nonatomic, strong) NSIndexPath * _Nullable indexPath;

//以下属性必须赋值
@property (nonatomic, copy) NSString * _Nullable cellId;

//以下属性可以自己赋值使用
@property (nonatomic, copy) ATMVVM_Collection_ItemVM_DidSelectItemBlock _Nullable didSelectItemBlock;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, strong) id _Nullable data;

- (void)setupData; //初始化数据
- (void)createLayout;
@end

#endif
