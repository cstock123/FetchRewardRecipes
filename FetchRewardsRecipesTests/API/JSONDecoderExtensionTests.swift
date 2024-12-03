//
//  JSONDecoderExtensionTests.swift
//  FetchRewardsRecipesTests
//
//  Created by Camden Stocker on 12/2/24.
//

import Testing
@testable import FetchRewardsRecipes
import Foundation

struct JSONDecoderExtensionTests {

    @Test("recipeResponseDecoder correctly converts snake case to camelCase")
    func setsKeyDecodingStrategy() throws {
        struct SampleSnake: Codable {
            let sample_key: String
        }
        struct SampleCamel: Codable {
            let sampleKey: String
        }
        let data = try JSONEncoder().encode(SampleSnake(sample_key: ""))
        
        
        #expect(throws: Never.self) {
            try JSONDecoder.recipeResponseDecoder
                .decode(SampleCamel.self, from: data)
        }
        #expect(throws: DecodingError.self) {
            try JSONDecoder.recipeResponseDecoder
                .decode(SampleSnake.self, from: data)
        }
    }

}
