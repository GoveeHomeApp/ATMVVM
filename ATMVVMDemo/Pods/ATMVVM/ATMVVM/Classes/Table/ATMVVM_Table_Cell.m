#import "ATMVVM_Table_Cell.h"

@implementation ATMVVM_Table_Cell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)setupData{}
- (void)setupSubviews{}
- (void)setupLayout{}
- (void)configWithRowVM:(ATMVVM_Table_RowVM *)rowVM indexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    [self configAndRefresh:rowVM];
}
- (void)configAndRefresh:(ATMVVM_Table_RowVM *)rowVM{
    self.rowVM = rowVM;
    [self refreshSubviews:NO];
    [self layoutIfNeeded];
}
- (void)refreshSubviews:(BOOL)isFromVM{
    
}

@end
