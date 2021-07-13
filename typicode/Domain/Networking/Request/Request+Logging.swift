//
//  Request+Logging.swift
//  typicode
//
//  Created by jinhyuk on 2021/07/09.
//

import Foundation
import RxAlamofire
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint("=======================================")
            debugPrint(self)
            debugPrint("=======================================")
        #endif
        return self
    }
}
