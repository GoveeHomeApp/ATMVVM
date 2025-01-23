#import <UIKit/UIKit.h>
#import "ATMVVM_Collection_SectionVM.h"
#import "ATMVVMDefine.h"
#ifndef ATMVVM_Collection_ReusableView_h
#define ATMVVM_Collection_ReusableView_h

@interface ATMVVM_Collection_ReusableView : UICollectionReusableView

@property (nonatomic, strong) ATMVVM_Collection_SectionVM * _Nullable sectionVM;
@property (nonatomic, strong) NSIndexPath * _Nullable indexPath;

- (void)setupData;
- (void)setupSubviews;
- (void)setupLayout;
- (void)configWithSectionVM:(nonnull ATMVVM_Collection_SectionVM *)sectionVM indexPath:(nonnull NSIndexPath *)indexPath;
- (void)refreshSubviews:(BOOL)isFromVM;

@end

#endif
