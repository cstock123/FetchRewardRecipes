//
//  API.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/26/24.
//

import Foundation

protocol APIEndpoint {
    func getUrlRequest() -> URLRequest?
}

class API<Resp: Codable> {
    func fetch(endpoint: APIEndpoint) async throws -> Resp {
        guard let urlRequest = endpoint.getUrlRequest() else {
            throw RecipesAPIError.invalidRequest
        }
        
        let response: Resp = try await sendRequest(request: urlRequest)    
        return response
    }
    
    func sendRequest(request: URLRequest) async throws -> Resp {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw RecipesAPIError.invalidResponse
        }
        
        try checkForErrors(response: response)
        let decodedResponse = try decodeResponseData(data: data)
        
        return decodedResponse
    }
    
    func checkForErrors(response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200..<300:
            break
        case 400 ..< 500:
            throw RecipesAPIError.fourHundredError
        case 500 ..< 600:
            throw RecipesAPIError.serverError
        default:
            throw RecipesAPIError.unknownError("Unexpected HTTP Response StatusCode: \(response.statusCode)")
        }
    }
    
    func decodeResponseData(data: Data) throws -> Resp {
        do {
            let responseDecoded = try JSONDecoder
                .recipeResponseDecoder
                .decode(Resp.self, from: data)
            
            return responseDecoded
        } catch {
            throw RecipesAPIError.decodingError
        }
    }
}
