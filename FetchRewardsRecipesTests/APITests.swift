//
//  APITests.swift
//  FetchRewardsRecipesTests
//
//  Created by Camden Stocker on 12/1/24.
//

import Foundation
import Testing
@testable import FetchRewardsRecipes

struct APITests {
    var api: API<Response>
    
    init() {
        api = API<Response>()
    }
    
    @Test("200 status codes does not throw error", arguments: 200 ..< 300)
    func doesNotThrowError(_ statusCode: Int) throws {
        let mockHttpResponse = try #require(mockResponse(statusCode: statusCode))
        
        #expect(throws: Never.self) {
            try api.checkForErrors(response: mockHttpResponse)
        }
    }

    @Test("400 status codes throws fourHundredError", arguments: 400 ..< 500)
    func throws400Error(_ statusCode: Int) throws {
        let mockHttpResponse = try #require(mockResponse(statusCode: statusCode))
        
        #expect(throws: RecipesAPIError.fourHundredError) {
            try api.checkForErrors(response: mockHttpResponse)
        }
    }
    
    @Test("500 status codes throws serverError", arguments: 500 ..< 600)
    func throwsServerError(_ statusCode: Int) throws {
        let mockHttpResponse = try #require(mockResponse(statusCode: statusCode))
        
        #expect(throws: RecipesAPIError.serverError) {
            try api.checkForErrors(response: mockHttpResponse)
        }
    }
    
    @Test("Unexpected HTTP Response codes throws unknownError", arguments: [100, 101, 600, 601])
    func throwsUnknownError(_ statusCode: Int) throws {
        let mockHttpResponse = try #require(mockResponse(statusCode: statusCode))
        
        #expect(
            throws: RecipesAPIError
                .unknownError(
                    "Unexpected HTTP Response StatusCode: \(statusCode)"
                )
        ) {
            try api.checkForErrors(response: mockHttpResponse)
        }
    }
    
    @Test("Malformed Response Data Throws Decoding Error")
    func throwsDecodingError() throws {
        struct MalformedResponse: Codable {}
        let emptyResponse = MalformedResponse()
        let emptyData = try JSONEncoder().encode(emptyResponse)
        
        #expect(
            throws: RecipesAPIError.decodingError
        ) {
            try api.decodeResponseData(data: emptyData)
        }
    }
    
    @Test("Valid Response Data deodes response")
    func returnsResponse() throws {
        let uuid = UUID().uuidString
        let response = Response(
            recipes: [
                Recipe(
                    uuid: uuid,
                    cuisine: "American",
                    name: "Pizza",
                    photoUrlLarge: "large_url_stub",
                    photoUrlSmall: "small_url_stub",
                    youtubeUrl: "youtube_url_stub")
            ]
        )
        let responseData = try JSONEncoder().encode(response)
        let decodedResponse = try api.decodeResponseData(data: responseData)
        
        #expect(decodedResponse.recipes.count == 1)
        #expect(response == decodedResponse)
    }
    
    func mockResponse(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: URL.applicationDirectory, // Use a random URL for mocking
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: [:]
        )
    }

}
