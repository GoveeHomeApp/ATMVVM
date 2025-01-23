#import <UIKit/UIKit.h>
#import "ATMVVM_Table_SectionVM.h"
#import "ATMVVM_Table_Cell.h"
#import "ATMVVM_Table_HeaderFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ATMVVM_Table_Proxy_Delegate <NSObject>
@optional
- (void)atmvvm_TableView:(UITableView *)tableView cell:(ATMVVM_Table_Cell *)cell indexPath:(NSIndexPath *)indexPath rowVM:(ATMVVM_Table_RowVM *)rowVM;
- (void)atmvvm_TableView:(UITableView *)tableView header:(ATMVVM_Table_HeaderFooterView *)header section:(NSInteger)section sectionVM:(ATMVVM_Table_SectionVM *)sectionVM;
- (void)atmvvm_TableView:(UITableView *)tableView footer:(ATMVVM_Table_HeaderFooterView *)header section:(NSInteger)section sectionVM:(ATMVVM_Table_SectionVM *)sectionVM;
@end

@interface ATMVVM_Table_Proxy : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, readonly) ATMVVM_Table_SectionVM * defaultSectionVM;
@property (nonatomic, strong, readonly) NSMutableArray<ATMVVM_Table_SectionVM *> * sectionVMs;

@property (nonatomic, weak) id forwarder; //只会转发没有proxy实现的方法
@property (nonatomic, weak) id<ATMVVM_Table_Proxy_Delegate> delegate; //只有部分功能的代理

@property (nonatomic, assign) BOOL isAutoLayoutCell;
@property (nonatomic, assign) BOOL isAutoLayoutHeader;
@property (nonatomic, assign) BOOL isAutoLayoutFooter;
@end

NS_ASSUME_NONNULL_END
