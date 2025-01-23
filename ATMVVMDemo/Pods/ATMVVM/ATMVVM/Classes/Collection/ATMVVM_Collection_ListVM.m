#import "ATMVVM_Collection_ListVM.h"

@interface ATMVVM_Collection_ListVM()
@property (nonatomic, strong) ATMVVM_Collection_Proxy * viewProxy;
@property (nonatomic, assign) ATMVVMState state;
@property (nonatomic, weak, nullable) UICollectionView * collectionView;
@end

@implementation ATMVVM_Collection_ListVM

- (instancetype)init{
    self = [super init];
    if (self) {
        self.viewProxy = [[ATMVVM_Collection_Proxy alloc] init];
        [self setupData];
    }
    return self;
}

- (instancetype)initWithViewProxy:(ATMVVM_Collection_Proxy *)viewProxy{
    self = [super init];
    if (self) {
        self.viewProxy = viewProxy;
        [self setupData];
    }
    return self;
}

- (void)setupData {}
- (void)createData {}
- (void)reloadData {
    [self.collectionView reloadData];
}
- (void)registerCollectionView:(UICollectionView * _Nonnull)collectionView {
    [collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.collectionView = collectionView;
}

- (void)didChangeState:(ATMVVMState)state flag:(NSInteger)flag msg:(NSString *)msg err:(NSError *)err {
    self.state = state;
    if(self.delegate && [self.delegate respondsToSelector:@selector(didChangeState:flag:msg:err:)]){
        [self.delegate didChangeState:state flag:flag msg:msg err:err];
    }
}


@end
