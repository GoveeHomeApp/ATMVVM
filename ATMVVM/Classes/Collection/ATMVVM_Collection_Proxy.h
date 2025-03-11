#import <UIKit/UIKit.h>

#import "ATMVVM_Collection_SectionVM.h"
#import "ATMVVM_Collection_Cell.h"
#import "ATMVVM_Collection_ReusableView.h"

#ifndef ATMVVM_Collection_Proxy_h
#define ATMVVM_Collection_Proxy_h

@protocol ATMVVM_Collection_Proxy_Delegate <NSObject>
@optional
- (void)atmvvm_CollectionView:(UICollectionView *)collectionView cell:(ATMVVM_Collection_Cell *)cell indexPath:(NSIndexPath *)indexPath itemVM:(ATMVVM_Collection_ItemVM *)itemVM;
- (void)atmvvm_CollectionView:(UICollectionView *)collectionView header:(ATMVVM_Collection_ReusableView *)header kind:(NSString *)kind indexPath:(NSIndexPath *)indexPath sectionVM:(ATMVVM_Collection_SectionVM *)sectionVM;
- (void)atmvvm_CollectionView:(UICollectionView *)collectionView footer:(ATMVVM_Collection_ReusableView *)footer kind:(NSString *)kind indexPath:(NSIndexPath *)indexPath sectionVM:(ATMVVM_Collection_SectionVM *)sectionVM;
@end


@interface ATMVVM_Collection_Proxy : NSObject<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readonly) ATMVVM_Collection_SectionVM * defaultSectionVM;
@property (nonatomic, strong, readonly) NSMutableArray<ATMVVM_Collection_SectionVM *> * sectionVMs;

@property (nonatomic, weak) id forwarder; //只会转发没有proxy实现的方法
@property (nonatomic, weak) id<ATMVVM_Collection_Proxy_Delegate> delegate; //只有部分功能的代理

@end

#endif
