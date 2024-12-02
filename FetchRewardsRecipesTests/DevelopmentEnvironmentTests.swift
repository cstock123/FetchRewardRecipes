//
//  DevelopmentEnvironmentTests.swift
//  FetchRewardsRecipesTests
//
//  Created by Camden Stocker on 12/1/24.
//

import Testing
@testable import FetchRewardsRecipes

struct DevelopmentEnvironmentTests {
    @Test("Production Environment")
    func hasCorrectProductionAttributes() {
        let productionEnvironment = DevelopmentEnvironment.production
        
        #expect(productionEnvironment.urlProtocol == "https")
        #expect(productionEnvironment.domain == "d3jbb8n5wk0qxi.cloudfront.net")
        #expect(productionEnvironment.baseApiUrl == "https://d3jbb8n5wk0qxi.cloudfront.net")
    }
    
    @Test("Development Environment")
    func hasCorrectDevelopmentAttributes() {
        let productionEnvironment = DevelopmentEnvironment.production
        
        #expect(productionEnvironment.urlProtocol == "https")
        #expect(productionEnvironment.domain == "d3jbb8n5wk0qxi.cloudfront.net")
        #expect(productionEnvironment.baseApiUrl == "https://d3jbb8n5wk0qxi.cloudfront.net")
    }

}
