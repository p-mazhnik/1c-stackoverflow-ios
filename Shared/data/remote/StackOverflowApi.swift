//
//  StackOverflowApi.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 20.11.2021.
//

import Foundation
import Combine

struct APIClient {

    struct Response<T> { // 1
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
//                let string1 = String(data: result.data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
//                print(string1)
                let value = try JSONDecoder().decode(T.self, from: result.data)
                
                return Response(value: value, response: result.response) // 5
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}

enum APIPath: String {
    case questions = "questions?page=1&pagesize=100&order=asc&sort=creation&tagged=Android&site=stackoverflow&filter=withbody"
    case answers = "/questions/{questionId}/answers?order=desc&sort=votes&site=stackoverflow&filter=withbody"
}

enum StackOverflowAPI {
    static let apiClient = APIClient()
    static let baseUrl = "https://api.stackexchange.com/2.2/"
    
    static func request<T: Codable>(_ path: APIPath) -> AnyPublisher<ListResponse<T>, Error> {
        guard let components = URLComponents(url: URL(string: baseUrl + path.rawValue)!, resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URLComponents") }
            
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request) // 5
            .map(\.value) // 6
            .eraseToAnyPublisher() // 7
    }
}

