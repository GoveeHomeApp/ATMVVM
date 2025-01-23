//
//  GVCollectionViewFlowLayout.h
//  GVToolbox
//
//  Created by liyebiao on 2020/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,UILayoutAlignment) {
    UILayoutAlignmentDefault = 0,//默认模式左对齐间距自适应
    UILayoutAlignmentLeft,//左对齐,间距一定
    UILayoutAlignmentRight,//右对齐,间距一定
    UILayoutAlignmentCenter,//居中对齐,间距一定
};


@interface GVCollectionViewFlowLayout : UICollectionViewFlowLayout

/**
 设置cell的对齐模式
 */
@property (nonatomic, assign) UILayoutAlignment layoutAlignment;

/**
 设置cell列间距
 默认值10
 */
@property (nonatomic, assign) float interitemSpacing;

@end

NS_ASSUME_NONNULL_END
