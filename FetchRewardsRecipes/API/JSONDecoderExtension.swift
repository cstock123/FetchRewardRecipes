//
//  JSONDecoderExtension.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/26/24.
//

import Foundation

extension JSONDecoder {
    static var recipeResponseDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
