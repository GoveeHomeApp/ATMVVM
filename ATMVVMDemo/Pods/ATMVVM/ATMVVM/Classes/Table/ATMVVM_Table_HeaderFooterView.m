#import "ATMVVM_Table_HeaderFooterView.h"

@implementation ATMVVM_Table_HeaderFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
        [self setupSubviews];
        [self setupLayout];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
- (void)configWithSectionVM:(ATMVVM_Table_SectionVM *)sectionVM section:(NSInteger)section{
    self.section = section;
    [self configAndRefresh:sectionVM];
}
- (void)configAndRefresh:(ATMVVM_Table_SectionVM *)sectionVM{
    self.sectionVM = sectionVM;
    [self refreshSubviews:NO];
    [self layoutIfNeeded];
}
- (void)refreshSubviews:(BOOL)isFromVM{}

@end
