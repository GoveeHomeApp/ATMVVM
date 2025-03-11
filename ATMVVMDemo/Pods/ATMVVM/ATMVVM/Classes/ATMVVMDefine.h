#ifndef ATMVVMDefine_h
#define ATMVVMDefine_h
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ATMVVMState) {
    ATMVVMStateIdl = 0,
    ATMVVMStateAdd,
    ATMVVMStateDelete,
    ATMVVMStateUpdate,
    ATMVVMStateQuery,
    ATMVVMStateSuccess,
    ATMVVMStateFailure,
    ATMVVMStateError,
    ATMVVMStateEmpty,
    ATMVVMStateNoNetwork,
    ATMVVMStateReload,
    ATMVVMStateLoad,
    ATMVVMStateNoData
};

@protocol ATMVVM_ListState_Delegate <NSObject>
- (void)didChangeState:(ATMVVMState)state flag:(NSInteger)flag msg:(NSString * _Nullable)msg err:(NSError * _Nullable)err;
@end

#endif
