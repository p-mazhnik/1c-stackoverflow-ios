//
//  StackOverflowApi.swift
//  swift-course-21
//
//  Created by Pavel Mazhnik on 20.11.2021.
//

import Foundation
import Combine

struct APIClient {

    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
//                let string1 = String(data: result.data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
//                print(string1)
                let value = try JSONDecoder().decode(T.self, from: result.data)
                
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum APIPath: String {
    case questions = "questions?page=1&pagesize=100&order=asc&sort=creation&tagged=Android&site=stackoverflow&filter=withbody"
}

enum StackOverflowAPI {
    static let apiClient = APIClient()
    static let baseUrl = "https://api.stackexchange.com/2.2/"
    
    static func request<T: Codable>(_ path: APIPath) -> AnyPublisher<ListResponse<T>, Error> {
        guard let components = URLComponents(url: URL(string: baseUrl + path.rawValue)!, resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URLComponents") }
            
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func requestAnswers(questionId: Int) -> AnyPublisher<ListResponse<Answer>, Error> {
        let path = "questions/\(questionId)/answers?order=desc&sort=votes&site=stackoverflow&filter=withbody"
        guard let components = URLComponents(url: URL(string: baseUrl + path)!, resolvingAgainstBaseURL: true)
        else { fatalError("Couldn't create URLComponents") }
            
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

