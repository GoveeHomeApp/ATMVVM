#import "ATMVVM_Collection_ReusableView.h"

@implementation ATMVVM_Collection_ReusableView

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
- (void)configWithSectionVM:(ATMVVM_Collection_SectionVM *)sectionVM indexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    [self configAndRefresh:sectionVM];
}
- (void)configAndRefresh:(ATMVVM_Collection_SectionVM *)sectionVM{
    self.sectionVM = sectionVM;
    [self refreshSubviews:NO];
    [self layoutIfNeeded];
}
- (void)refreshSubviews:(BOOL)isFromVM{}

@end
