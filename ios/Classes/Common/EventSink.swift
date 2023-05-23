import enum SwiftProtobuf.BinaryEncodingError
import Flutter

struct EventSink {

    private let name: String
    private let sink: FlutterEventSink

    init(name: String, _ sink: @escaping FlutterEventSink) {
        self.name = name
        self.sink = sink
    }

    func add(_ event: PlatformMethodResult) {
        switch event {
        case .success(let message):
            if let message = message {
                do {
                    sink(FlutterStandardTypedData(bytes: try message.serializedData()))
                } catch let error as BinaryEncodingError {
                    sink(FlutterError(code: "500", message: error.localizedDescription, details: nil))
                } catch {
                    sink(FlutterError(code: "500", message: "未错误知", details: nil))
                }
            } else {
                sink(nil)
            }
        case .failure(let error):
            sink(error)
        }
    }
}

