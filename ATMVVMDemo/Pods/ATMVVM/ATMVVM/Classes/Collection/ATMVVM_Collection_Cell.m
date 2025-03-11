#import "ATMVVM_Collection_Cell.h"

@implementation ATMVVM_Collection_Cell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
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
- (void)configWithItemVM:(ATMVVM_Collection_ItemVM *)itemVM indexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    [self configAndRefresh:itemVM];
}
- (void)configAndRefresh:(ATMVVM_Collection_ItemVM *)itemVM{
    self.itemVM = itemVM;
    
    [self refreshSubviews:NO];
    [self layoutIfNeeded];
}
- (void)refreshSubviews:(BOOL)isFromVM{}

@end
