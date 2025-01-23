//
//  BaseAlignCollectionViewFlowLayout.h
//  BaseModule
//
//  Created by TingtingLi on 2019/12/2.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, AlignType) {
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};

NS_ASSUME_NONNULL_BEGIN

@interface BaseAlignCollectionViewFlowLayout : UICollectionViewFlowLayout

//cell对齐方式
@property (nonatomic, assign) AlignType cellType;

- (instancetype)initWithType:(AlignType)cellType;

@end

NS_ASSUME_NONNULL_END
