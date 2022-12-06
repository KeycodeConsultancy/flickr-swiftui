import Foundation

protocol ServiceProtocol {
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T
}
