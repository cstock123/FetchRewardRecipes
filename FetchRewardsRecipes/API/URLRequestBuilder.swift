//
//  URLRequestBuilder.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/26/24.
//

import Foundation

enum HTTPMethod: String {
    case get, post, put, delete
}

class URLRequestBuilder {
    func buildRequest(
        path: String,
        httpMethod: HTTPMethod
    ) -> URLRequest? {
        #if DEBUG
        let environment = DevelopmentEnvironment.development
        #else
        let environment = DevelopmentEnvironment.production
        #endif
        
        guard let url = URL(string: "\(environment.baseApiUrl)/\(path)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
