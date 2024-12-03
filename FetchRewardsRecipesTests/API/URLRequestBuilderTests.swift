//
//  URLRequestBuilderTests.swift
//  FetchRewardsRecipesTests
//
//  Created by Camden Stocker on 12/2/24.
//

import Testing
import Foundation
@testable import FetchRewardsRecipes

struct URLRequestBuilderTests {
    let urlRequestBuilder = URLRequestBuilder()

    @Test("buildRequest sets correct attributes on URLRequest", arguments: HTTPMethod.allCases)
    func buildsURLRequest(_ method: HTTPMethod) throws {
        let testPath = "testPath"
        let request = try #require(urlRequestBuilder.buildRequest(path: testPath, httpMethod: method))
        
        let environment = DevelopmentEnvironment.development
        let expectedURL = try #require(URL(string: "\(environment.baseApiUrl)/\(testPath)"))
        
        #expect(request.url == expectedURL)
        #expect(request.httpMethod == method.rawValue.uppercased())
        #expect(request.value(forHTTPHeaderField: "Accept") == "application/json")
    }
}
