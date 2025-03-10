//
//  GHDecorationFlowLayout.h
//  A_Lib_UI
//
//  Created by HK on 2022/10/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  GHDecorationFlowLayoutDelegate <NSObject, UICollectionViewDelegateFlowLayout>

@required
//自定义每个section的背景view，需要继承UICollectionReusableView，返回类名
- (nullable NSString*)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout registerBackView:(NSInteger)section;
@optional
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForBackViewAtIndex:(NSInteger)section;
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backViewStyleInsection:(NSInteger)section;

@end

@interface GHDecorationViewLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic, assign) NSInteger style;
@end

@interface GHDecorationFlowLayout : UICollectionViewFlowLayout
@property (nonatomic,weak) id<GHDecorationFlowLayoutDelegate> delegate;


- (void)registerDecorationView:(NSArray<NSString*>*)classNames;

@end

NS_ASSUME_NONNULL_END
