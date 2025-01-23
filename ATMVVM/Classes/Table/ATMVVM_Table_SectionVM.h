#import <UIKit/UIKit.h>

#import "ATMVVM_Table_RowVM.h"

NS_ASSUME_NONNULL_BEGIN

@class ATMVVM_Table_SectionVM;
typedef void (^ATMVVM_Table_SectionVM_ReloadViewBlock)(void);
typedef void (^ATMVVM_Table_SectionVM_RefreshViewBlock)(void);

@interface ATMVVM_Table_SectionVM : NSObject

//这几个属性不能自己赋值使用
@property (nonatomic, copy, readonly) ATMVVM_Table_SectionVM_ReloadViewBlock _Nonnull reloadViewBlock;
@property (nonatomic, copy, readonly) ATMVVM_Table_SectionVM_RefreshViewBlock _Nonnull refreshHeaderViewBlock;
@property (nonatomic, copy, readonly) ATMVVM_Table_SectionVM_RefreshViewBlock _Nonnull refreshFooterViewBlock;

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSIndexPath * _Nullable indexPath;

//以下属性可以自己赋值使用
@property (nonatomic, copy) NSString * _Nullable headerId;
@property (nonatomic, copy) NSString * _Nullable footerId;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSMutableArray<ATMVVM_Table_RowVM *> * rowVMs;

- (void)setupData;

- (void)createLayout;

@end

NS_ASSUME_NONNULL_END
