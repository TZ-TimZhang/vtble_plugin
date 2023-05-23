//
//  DBlog.swift
//  ble_plugin
//
//  Created by 张帅 on 2023/2/24.
//

import Foundation

/// 输出日志
///
/// - info: normal
/// - success: success
/// - error: error
/// - warning: 警告，可不处理的
enum DBLog {
    case info
    case success
    case error
    case warning
}

extension DBLog {

    /// 输出默认info的日志
    static func cat<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
        self.info.cat(message)
    }

    /// 输入日志，根据类型，区别符号
    ///
    /// - Parameters:
    ///   - message: 显示的信息
    func cat<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
        if !log {
            return
        }
        #if DEBUG
            var log: String
            switch self {
            case .info:
                log = " 🎼 - " + "\(message)"
            case .success:
                log = " ✅ - " + "\(message)"
            case .error:
                log = " ❌ - " + "\(message)"
            case .warning:
                log = " ⚠️ - " + "\(message)"
            }
            print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(log)")
        #endif
    }
}
