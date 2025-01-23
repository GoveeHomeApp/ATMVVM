#import "UITableView+ATMVVM.h"

@implementation UITableView (ATMVVM)

- (void)setupListVM:(ATMVVM_Table_ListVM *)listVM {
    [listVM registerTableView:self];
}

- (void)setupWithViewProxy:(ATMVVM_Table_Proxy *)viewProxy {
    self.delegate = viewProxy;
    self.dataSource = viewProxy;
    
    if(@available(iOS 15.0, *)){
        self.sectionHeaderTopPadding = 0;
    }
    [self registerClass:NSClassFromString(@"ATMVVM_Table_HeaderFooterView") forHeaderFooterViewReuseIdentifier:@"ATMVVM_Table_HeaderFooterView"];
}


@end
