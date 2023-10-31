//
//  CoreDataMoviesResponseStorage.swift
//  Movies
//
//  Created by wonki on 10/31/23.
//

import Foundation
import CoreData

final class CoreDataMoviesResponseStorage {
    
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = .shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    
    // MARK: - Private
    
    private func fetchRequest(
        for requestDto: MoviesRequestDTO
    ) -> NSFetchRequest<MoviesRequestEntity> {
        let request = MoviesRequestEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(MoviesRequestEntity.query),
                                        requestDto.query,
                                        #keyPath(MoviesRequestEntity.page),
                                        requestDto.page)
        return request
    }
    
}

extension CoreDataMoviesResponseStorage: MoviesResponseStorage {
    
    func getResponse(for request: MoviesRequestDTO) async throws -> MoviesResponseDTO? {
        try await withUnsafeThrowingContinuation { continuation in
            coreDataStorage.performBackgroundTask { context in
                do {
                    let fetchRequest = self.fetchRequest(for: request)
                    let requestEntity = try context.fetch(fetchRequest).first
                    
                    continuation.resume(returning: requestEntity?.response?.toDTO())
                } catch {
                    continuation.resume(throwing: CoreDataStorageError.readError(error))
                }
            }
        }
    }
    
    func save(
        response: MoviesResponseDTO,
        for requestDto: MoviesRequestDTO
    ) {
        coreDataStorage.performBackgroundTask { context in
        }
    }
}
