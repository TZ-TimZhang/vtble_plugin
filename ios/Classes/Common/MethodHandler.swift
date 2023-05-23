import Flutter

final class MethodHandler<Context: AnyObject> {

    private let methods: [String: AnyPlatformMethod<Context>]

    init(_ methods: [AnyPlatformMethod<Context>]) {
        self.methods = methods.reduce(into: [:], { $0[$1.name] = $1 })
    }

    func handle(in context: Context, _ call: FlutterMethodCall, completion: @escaping FlutterResult) {
        guard let method = methods[call.method]
        else {
            completion(FlutterError(code: "500", message: "不支持该方法", details: nil))
            return
        }

        method.call(in: context, arguments: call.arguments, completion: completion)
    }
}
