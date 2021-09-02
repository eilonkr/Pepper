//
//  JSONOperationsProvider.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 31/08/2021.
//

import Foundation

struct LocalJSONOperationsProvider: OperationsProviding {
    enum OperationsProviderError: Error {
        case failedToReadFile
        case failedToDecode
        case unknown(Error)
    }
    
    private let fileName: String
    private let bundle: Bundle
    
    init(fileName: String, in bundle: Bundle) {
        self.fileName = fileName
        self.bundle = bundle
    }
    
    func fetch(callback: @escaping (Result<[Operation], Error>) -> Void) {
        let fileNameComponents = fileName.components(separatedBy: ".")
        guard let resource = fileNameComponents.first, let ext = fileNameComponents.last,
              let jsonURL = Bundle.main.url(forResource: resource, withExtension: ext),
              let data = try? Data(contentsOf: jsonURL) else {
           return callback(.failure(OperationsProviderError.failedToReadFile))
        }
        
        let decoder = JSONDecoder()
        do {
            let container = try decoder.decode(OperationsContainer.self, from: data)
            callback(.success(container.operations.compactMap { $0 }))
        } catch is DecodingError {
            callback(.failure(OperationsProviderError.failedToDecode))
        } catch {
            print("Unknown error: \(error)")
            callback(.failure(OperationsProviderError.unknown(error)))
        }
    }
}
