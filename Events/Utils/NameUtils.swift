

import Foundation

class NameUtils {
    
    static func initialsFromName(name: String) -> String {
        
        var initials = ""
        
        // mot à ignorer
        let ignore = ["of", "a", "for", "an", "the"]

        for word in name.split(separator: " ") {
            if (!ignore.contains(word.lowercased())) {
                initials = initials + String(word.first!)
            }
        }

        return initials.uppercased()
    }
}
