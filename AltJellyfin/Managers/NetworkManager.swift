import Foundation
import Combine

public protocol APIRequest {
    var path: String? { get }
    var httpMethod: HTTPRequestMethod { get }
    var params: [String: Any]? { get }
    var body: [String]? { get }

    func asUrlComponent() -> URLComponents?
}

public enum HTTPRequestMethod {
    case get
    case post
}

public final class NetworkManager: NSObject {

    public static let shared = NetworkManager()
    private let session = URLSession.shared

    override private init() {}

    func fetch<T: Decodable>(_ apiCall: APIRequest) -> AnyPublisher<T, AppError> {
        let comp = apiCall.asUrlComponent()
        return session.dataTaskPublisher(for: (comp?.url ?? URL(string: "")!))
            .tryMap() { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .map { $0 }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .map { values in
                return values
            }
            .mapError({ error in
                print("----", error)
                return AppError.systemError // TODO: handleError
            })
            .eraseToAnyPublisher()
    }
}

extension Encodable {
    func asDictionary() throws -> [String: String] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else {
            throw NSError()
        }
        
        return dictionary.compactMapValues { $0 }
    }
}
