#import <UIKit/UIKit.h>

#import "ATMVVM_Collection_ItemVM.h"

#ifndef ATMVVM_Collection_SectionVM_h
#define ATMVVM_Collection_SectionVM_h

@class ATMVVM_Collection_SectionVM;
typedef void (^ATMVVM_Collection_SectionVM_ReloadSectionBlock)(void);
typedef void (^ATMVVM_Collection_SectionVM_ReloadViewBlock)(void);
typedef void (^ATMVVM_Collection_SectionVM_RefreshViewBlock)(void);

@interface ATMVVM_Collection_SectionVM : NSObject

//这几个属性不能自己赋值使用
@property (nonatomic, copy, readonly) ATMVVM_Collection_SectionVM_ReloadSectionBlock _Nonnull reloadSectionBlock;
@property (nonatomic, copy, readonly) ATMVVM_Collection_SectionVM_ReloadViewBlock _Nonnull reloadViewBlock;
@property (nonatomic, copy, readonly) ATMVVM_Collection_SectionVM_RefreshViewBlock _Nonnull refreshHeaderViewBlock;
@property (nonatomic, copy, readonly) ATMVVM_Collection_SectionVM_RefreshViewBlock _Nonnull refreshFooterViewBlock;

@property (nonatomic, weak) UICollectionView * _Nullable collectionView;
@property (nonatomic, strong) NSIndexPath * _Nullable indexPath;

//以下属性可以自己赋值使用
@property (nonatomic, copy) NSString * _Nullable headerId;
@property (nonatomic, copy) NSString * _Nullable footerId;

@property (nonatomic, assign) CGSize headerSize;
@property (nonatomic, assign) CGSize footerSize;

@property (nonatomic, strong) NSMutableArray<ATMVVM_Collection_ItemVM *> * _Nonnull itemVMs;

@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

- (void)setupData;

- (void)createLayout;
@end

#endif
