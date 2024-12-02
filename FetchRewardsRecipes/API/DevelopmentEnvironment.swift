//
//  DevelopmentEnvironment.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/26/24.
//

enum URLProtocol: String {
    case http, https
}

enum Domain: String {
    case cloudfront = "d3jbb8n5wk0qxi.cloudfront.net"
}

// At the moment, our environments are the same, but this allows for easy modification in the future to support multiple environments.
enum DevelopmentEnvironment {
    case production
    case development
    
    var urlProtocol: String {
        switch self {
        case .production:
            URLProtocol.https.rawValue
        case .development:
            URLProtocol.https.rawValue
        }
    }
    
    var domain: String { Domain.cloudfront.rawValue }
    
    var baseApiUrl: String {
        "\(urlProtocol)://\(domain)"
    }
}
