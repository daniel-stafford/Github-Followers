//
//  PersistanceManager.swift
//  GithubFollowers
//
//  Created by Daniel Stafford on 2/8/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    enum Keys {
        static let favorites = "Favorites"
    }

    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case let .success(favorites):
                // allow for mutation
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
					retrievedFavorites.removeAll { $0.login == favorite.login }
                }
				completed(saveFavorites(favorites: retrievedFavorites))
            case let .failure(error):
                completed(error)
            }
        }
    }

    private static let defaults = UserDefaults.standard
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            // first time running, so empty array
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    static func saveFavorites(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
