#import <UIKit/UIKit.h>
#import "ATMVVM_Table_SectionVM.h"
NS_ASSUME_NONNULL_BEGIN

@interface ATMVVM_Table_HeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) ATMVVM_Table_SectionVM * _Nullable sectionVM;
@property (nonatomic, assign) NSInteger section;

- (void)setupData;
- (void)setupSubviews;
- (void)setupLayout;
- (void)configWithSectionVM:(ATMVVM_Table_SectionVM *)sectionVM section:(NSInteger)section;
- (void)refreshSubviews:(BOOL)isFromVM;

@end

NS_ASSUME_NONNULL_END
