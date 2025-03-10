#import "ATMVVM_Collection_Proxy.h"

@interface ATMVVM_Collection_Proxy()

@property (nonatomic, strong) ATMVVM_Collection_SectionVM * defaultSectionVM;
@property (nonatomic, strong) NSMutableArray<ATMVVM_Collection_SectionVM *> * sectionVMs;

@end

@implementation ATMVVM_Collection_Proxy

- (ATMVVM_Collection_SectionVM *)defaultSectionVM {
    if(!_defaultSectionVM){
        _defaultSectionVM = [[ATMVVM_Collection_SectionVM alloc] init];
    }
    return _defaultSectionVM;
}

- (NSMutableArray<ATMVVM_Collection_SectionVM *> *)sectionVMs {
    if(!_sectionVMs){
        _sectionVMs = [NSMutableArray new];
    }
    return _sectionVMs;
}

- (ATMVVM_Collection_SectionVM *)getSectionVM:(NSInteger)section {
    if(_defaultSectionVM == nil) {
        if(section < self.sectionVMs.count){
            return self.sectionVMs[section];
        }
        return nil;
    }
    return self.defaultSectionVM;
}

- (ATMVVM_Collection_ItemVM *)getItemVM:(NSInteger)section item:(NSInteger)item {
    ATMVVM_Collection_SectionVM * sectionVM = [self getSectionVM:section];
    if(item < sectionVM.itemVMs.count){
        return sectionVM.itemVMs[item];
    }
    return nil;
}

- (ATMVVM_Collection_ItemVM *)getItemVM:(NSIndexPath *)indexPath {
    return [self getItemVM:indexPath.section item:indexPath.item];
}

//UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(_defaultSectionVM == nil){
        return self.sectionVMs.count;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self getSectionVM:section].itemVMs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ATMVVM_Collection_SectionVM * sectionVM = [self getSectionVM:indexPath.section];
    sectionVM.indexPath = indexPath;
    sectionVM.collectionView = collectionView;
    
    ATMVVM_Collection_ItemVM * itemVM = [self getItemVM:indexPath];
    itemVM.indexPath = indexPath;
    itemVM.collectionView = collectionView;
    if(!itemVM){
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    ATMVVM_Collection_Cell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemVM.cellId forIndexPath:indexPath];
    [cell configWithItemVM:itemVM indexPath:indexPath];
    if(self.delegate && [self.delegate respondsToSelector:@selector(atmvvm_CollectionView:cell:indexPath:itemVM:)]){
        [self.delegate atmvvm_CollectionView:collectionView cell:cell indexPath:indexPath itemVM:itemVM];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ATMVVM_Collection_SectionVM * sectionVM = [self getSectionVM:indexPath.section];
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if(sectionVM.headerId){
            ATMVVM_Collection_ReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionVM.headerId forIndexPath:indexPath];
            [header configWithSectionVM:sectionVM indexPath:indexPath];
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(atmvvm_CollectionView:header:kind:indexPath:sectionVM:)]){
                [self.delegate atmvvm_CollectionView:collectionView header:header kind:kind indexPath:indexPath sectionVM:sectionVM];
            }
            return header;
        }
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        if(sectionVM.footerId){
            ATMVVM_Collection_ReusableView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionVM.footerId forIndexPath:indexPath];
            [footer configWithSectionVM:sectionVM indexPath:indexPath];
            if(self.delegate && [self.delegate respondsToSelector:@selector(atmvvm_CollectionView:footer:kind:indexPath:sectionVM:)]){
                [self.delegate atmvvm_CollectionView:collectionView footer:footer kind:kind indexPath:indexPath sectionVM:sectionVM];
            }
            return footer;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ATMVVM_Collection_ItemVM * itemVM = [self getItemVM:indexPath];
    return itemVM.itemSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    ATMVVM_Collection_SectionVM * sectionVM = [self getSectionVM:section];
    return sectionVM.headerSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    ATMVVM_Collection_SectionVM * sectionVM = [self getSectionVM:section];
    return sectionVM.footerSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return [self getSectionVM:section].sectionInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self getSectionVM:section].minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self getSectionVM:section].minimumInteritemSpacing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ATMVVM_Collection_ItemVM * itemVM = [self getItemVM:indexPath];
    if(itemVM.didSelectItemBlock){
        itemVM.didSelectItemBlock(collectionView, indexPath, itemVM);
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    if (self.forwarder && [self.forwarder respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:self.forwarder];
    else
        [super forwardInvocation:anInvocation];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if(self.isAutoLayoutCell){
        SEL cellSizeSelector = @selector(collectionView:layout:sizeForItemAtIndexPath:);
        if(cellSizeSelector == aSelector){
            return NO;
        }
    }
    if(self.isAutoLayoutHeader){
        SEL headerSizeSelector = @selector(collectionView:layout:referenceSizeForHeaderInSection:);
        if(headerSizeSelector == aSelector){
            return NO;
        }
    }
    if(self.isAutoLayoutFooter){
        SEL footerSizeSelector = @selector(collectionView:layout:referenceSizeForFooterInSection:);
        if(footerSizeSelector == aSelector){
            return NO;
        }
    }
    return [super respondsToSelector:aSelector] || (self.forwarder && [self.forwarder respondsToSelector:aSelector]);
}


@end
