//
//  NetworkService.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import Foundation

import Moya
import Combine

enum NetworkService {
    case getUsers
    case getAlbums(userId: Int)
    case getPhotos(albumId: Int)
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getAlbums:
            return "/albums"
        case .getPhotos:
            return "/photos"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .getAlbums(let userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
        case .getPhotos(let albumId):
            return .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.queryString)

        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}


// Define a Combine publisher for Moya requests
extension MoyaProvider {
    func requestPublisher(_ target: Target) -> AnyPublisher<Response, MoyaError> {
        return Future<Response, MoyaError> { promise in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    promise(.success(response))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}



