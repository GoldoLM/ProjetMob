
import Foundation


enum ApiError: Error {
    case httpError(Error)
    case apiError(String, String)
    case parseError(Error, String)
}
