//
//  NetworkManager.swift
//  CryptoVIPER
//
//  Created by Mine Rala on 7.03.2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func makeRequest<T: Decodable>(endpoint: Endpoint, type: T.Type) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
    func makeRequest<T: Decodable>(endpoint: Endpoint, type: T.Type) async throws -> T {
        guard let url = endpoint.url else {
            throw CRError.invalidKeyword
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw CRError.invalidResponse
        }

        let decoder = JSONDecoder()
        do {
            let decodedObject = try decoder.decode(T.self, from: data)
            return decodedObject
        } catch {
            throw CRError.invalidData
        }
    }
}
