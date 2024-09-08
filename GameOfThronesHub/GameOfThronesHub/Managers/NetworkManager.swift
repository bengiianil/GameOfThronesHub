//
//  NetworkManager.swift
//  GameOfThronesHub
//
//  Created by Bengi Anıl on 8.09.2024.
//

import Foundation

enum AppError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case invalidStatusCode(_ statusCode: Int)
    case serverError
    case decodeError
    case noData
}

class NetworkManager {
    
    static var shared = NetworkManager()

    func fetchData<T: Decodable>(url: String) async throws -> T  {
        guard let url = URL(string: url) else {
            throw AppError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AppError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw AppError.invalidStatusCode(httpResponse.statusCode)
            }
            

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            print(decodedData)
            
            return decodedData
        } catch {
            throw error
        }
    }
    
    func sendData() {
        
    }
}
