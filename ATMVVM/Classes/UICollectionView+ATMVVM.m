#import "UICollectionView+ATMVVM.h"

@implementation UICollectionView(ATMVVM)

- (void)setupListVM:(ATMVVM_Collection_ListVM *)listVM {
    [listVM registerCollectionView:self];
}

- (void)setupWithViewProxy:(ATMVVM_Collection_Proxy *)viewProxy {
    self.delegate = viewProxy;
    self.dataSource = viewProxy;
    [self registerClass:NSClassFromString(@"ATMVVM_Collection_ReusableView") forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ATMVVM_Collection_ReusableView"];
    [self registerClass:NSClassFromString(@"ATMVVM_Collection_ReusableView") forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ATMVVM_Collection_ReusableView"];
}

@end
