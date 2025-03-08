//
//  MockNetworkManager.swift
//  CryptoVIPERTests
//
//  Created by Mine Rala on 8.03.2025.
//

import Foundation
@testable import CryptoVIPER

final class MockNetworkManager: NetworkManagerProtocol {
    // MARK: - Test Kontrolleri
    var makeRequestCalled = false
    var shouldReturnError = false

    // MARK: - Mock Verileri
    var mockData: Data?
    var mockError: CRError?
    var mockList: [Crypto] = []
    // MARK: - Methods
    func makeRequest<T: Decodable>(endpoint: Endpoint, type: T.Type) async throws -> T {
        makeRequestCalled = true

        if shouldReturnError {
            throw mockError ?? CRError.invalidResponse
        }

        if !mockList.isEmpty {
            let jsonData = try JSONEncoder().encode(mockList)
            guard let decodedObject = try? JSONDecoder().decode(T.self, from: jsonData) else {
                throw CRError.invalidData
            }
            return decodedObject
        }

        // Eğer elimizde mockData varsa onu kullan
        guard let data = mockData else {
            throw CRError.invalidData
        }

        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw CRError.invalidData
        }
    }
}

