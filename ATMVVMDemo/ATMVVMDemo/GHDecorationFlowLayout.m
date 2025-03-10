//
//  GHDecorationFlowLayout.m
//  A_Lib_UI
//
//  Created by HK on 2022/10/27.
//

#import "GHDecorationFlowLayout.h"

@implementation GHDecorationViewLayoutAttributes

@end

@interface GHDecorationFlowLayout ()
@property (nonatomic, strong) NSMutableArray *attributesArray;
@end

@implementation GHDecorationFlowLayout
- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat totalWidth = self.collectionView.frame.size.width;
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    self.attributesArray = [NSMutableArray new];
    for (int index = 0; index < sectionCount; index++) {
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:registerBackView:)]) {
            NSString* className = [self.delegate collectionView:self.collectionView layout:self registerBackView:index];
            if (className) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:index];
                UICollectionViewLayoutAttributes *fistAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
                CGFloat height = 0;
                NSUInteger count = [self.collectionView numberOfItemsInSection:index];
                if (count > 0) {
                    if (!fistAttr) {
                        fistAttr = [self layoutAttributesForItemAtIndexPath:indexPath];
                    }
                    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:count - 1 inSection:index];
                    UICollectionViewLayoutAttributes  *lastAttr = [self layoutAttributesForItemAtIndexPath:lastIndexPath];
                    height = CGRectGetMaxY(lastAttr.frame) - CGRectGetMinY(fistAttr.frame);
                } else if (fistAttr) {
                    height = CGRectGetHeight(fistAttr.frame);
                }
                
                UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
                if (footerAttr) {
                    CGFloat footerHeight = CGRectGetHeight(footerAttr.frame);
                    if (footerHeight > 0) {
                        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
                        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
                            edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
                        }
                        height += (edgeInsets.bottom + footerHeight);
                    }
                }
                
                UIEdgeInsets inset = UIEdgeInsetsZero;
                if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForBackViewAtIndex:)]) {
                    inset = [self.delegate collectionView:self.collectionView layout:self insetForBackViewAtIndex:index];
                }
                NSInteger style = 0;
                if ([self.delegate respondsToSelector:@selector(collectionView:layout:backViewStyleInsection:)]) {
                    style = [self.delegate collectionView:self.collectionView layout:self backViewStyleInsection:index];
                }
                
                GHDecorationViewLayoutAttributes *attr = [GHDecorationViewLayoutAttributes layoutAttributesForDecorationViewOfKind:className withIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
                attr.style = style;
                attr.zIndex = -1000;
                attr.frame = CGRectMake(inset.left, CGRectGetMinY(fistAttr.frame) + inset.top, totalWidth - (inset.left + inset.right) ,  height - (inset.top + inset.bottom));
                
                [self.attributesArray addObject:attr];
            }
        }
    }
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray  *attributes = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    for (UICollectionViewLayoutAttributes *attribute in self.attributesArray) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [attributes addObject:attribute];
        }
    }
    return attributes;
}

// 注册所有的背景view(传入类名)
- (void)registerDecorationView:(NSArray<NSString*>*)classNames {
    for (NSString* className in classNames) {
        if (className.length > 0) {
            [self registerClass:NSClassFromString(className) forDecorationViewOfKind:className];
        }
    }
}

@end
