//class GetAuth {
//
////    private weak var remoteDataSource: AuthApiDataSource?
////
////    init(remoteDataSource: AuthApiDataSource) {
////        self.remoteDataSource = remoteDataSource
////    }
////
////    func authorize(authRequest: AuthRequest, _ authCallBack: @escaping (BaseCallback<AuthResponse>) -> Void) {
////        remoteDataSource?.authorize(authRequest: authRequest) { (callback) in
////            callback.onSuccess { (authResponse) in
////                let callbackSuccess = BaseCallback.success(authResponse)
////                authCallBack(callbackSuccess)
////            }
////
////            callback.onFailed { error in
////                let callbackFailed = BaseCallback<AuthResponse>.failed(error: error)
////                authCallBack(callbackFailed)
////            }
////
////        }
////
////    }
//
//}
