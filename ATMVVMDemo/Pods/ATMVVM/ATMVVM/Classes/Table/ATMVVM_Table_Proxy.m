#import "ATMVVM_Table_Proxy.h"


@interface ATMVVM_Table_Proxy()
@property (nonatomic, strong) ATMVVM_Table_SectionVM * defaultSectionVM;
@property (nonatomic, strong) NSMutableArray<ATMVVM_Table_SectionVM *> * sectionVMs;
@end

@implementation ATMVVM_Table_Proxy

- (ATMVVM_Table_SectionVM *)defaultSectionVM {
    if(!_defaultSectionVM){
        _defaultSectionVM = [[ATMVVM_Table_SectionVM alloc] init];
    }
    return _defaultSectionVM;
}

- (NSMutableArray<ATMVVM_Table_SectionVM *> *)sectionVMs {
    if(!_sectionVMs){
        _sectionVMs = [NSMutableArray new];
    }
    return _sectionVMs;
}

- (ATMVVM_Table_SectionVM *)getSectionVM:(NSInteger)section {
    if(_defaultSectionVM == nil) {
        if(section < self.sectionVMs.count){
            return self.sectionVMs[section];
        }
        return nil;
    }
    return self.defaultSectionVM;
}

- (ATMVVM_Table_RowVM *)getRowVM:(NSInteger)section row:(NSInteger)row {
    ATMVVM_Table_SectionVM * sectionVM = [self getSectionVM:section];
    if(row < sectionVM.rowVMs.count){
        return sectionVM.rowVMs[row];
    }
    return nil;
}

- (ATMVVM_Table_RowVM *)getRowVM:(NSIndexPath *)indexPath {
    return [self getRowVM:indexPath.section row:indexPath.row];
}

//MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_defaultSectionVM == nil){
        return self.sectionVMs.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self getSectionVM:section].rowVMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ATMVVM_Table_RowVM * rowVM = [self getRowVM:indexPath];
    if(!rowVM){
        return [[UITableViewCell alloc] init];
    }
    ATMVVM_Table_Cell * cell = [tableView dequeueReusableCellWithIdentifier:rowVM.cellId forIndexPath:indexPath];
    [cell configWithRowVM:rowVM indexPath:indexPath];
    if(self.delegate && [self.delegate respondsToSelector:@selector(atmvvm_TableView:cell:indexPath:rowVM:)]){
        [self.delegate atmvvm_TableView:tableView cell:cell indexPath:indexPath rowVM:rowVM];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ATMVVM_Table_SectionVM * sectionVM = [self getSectionVM:indexPath.section];
    sectionVM.tableView = tableView;
    sectionVM.indexPath = indexPath;
    
    ATMVVM_Table_RowVM * rowVM = [self getRowVM:indexPath];
    rowVM.tableView = tableView;
    rowVM.indexPath = indexPath;
    
    if(self.isAutoLayoutCell){
        return UITableViewAutomaticDimension;
    }else{
        return rowVM.rowHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    ATMVVM_Table_SectionVM * sectionVM = [self getSectionVM:section];
    if(self.isAutoLayoutHeader) {
        return UITableViewAutomaticDimension;
    }else{
        return sectionVM.headerHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    ATMVVM_Table_SectionVM * sectionVM = [self getSectionVM:section];
    if(self.isAutoLayoutFooter) {
        return UITableViewAutomaticDimension;
    }else{
        return sectionVM.footerHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ATMVVM_Table_SectionVM * sectionVM = [self getSectionVM:section];
    if(sectionVM.headerId){
        ATMVVM_Table_HeaderFooterView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionVM.headerId];
        [header configWithSectionVM:sectionVM section:section];
        if(self.delegate && [self.delegate respondsToSelector:@selector(atmvvm_TableView:header:section:sectionVM:)]){
            [self.delegate atmvvm_TableView:tableView header:header section:section sectionVM:sectionVM];
        }
        return header;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ATMVVM_Table_SectionVM * sectionVM = [self getSectionVM:section];
    if(sectionVM.footerId){
        ATMVVM_Table_HeaderFooterView * footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionVM.footerId];
        [footer configWithSectionVM:sectionVM section:section];
        if(self.delegate && [self.delegate respondsToSelector:@selector(atmvvm_TableView:header:section:sectionVM:)]){
            [self.delegate atmvvm_TableView:tableView footer:footer section:section sectionVM:sectionVM];
        }
        return footer;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ATMVVM_Table_RowVM * rowVM = [self getRowVM:indexPath];
    if(rowVM.didSelectItemBlock){
        rowVM.didSelectItemBlock(tableView, indexPath, rowVM);
    }
}

//MARK: -
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    if (self.forwarder && [self.forwarder respondsToSelector:[anInvocation selector]])
        [anInvocation invokeWithTarget:self.forwarder];
    else
        [super forwardInvocation:anInvocation];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    return [super respondsToSelector:aSelector] || (self.forwarder && [self.forwarder respondsToSelector:aSelector]);
}


@end
