

import Foundation

class DateUtils {
    private static let dateFormatter = DateFormatter()
    
    
    
    static func dateFromString(from: String) -> Date {
        return dateFormatter.date(from: from) ?? Date()
    }
    

    static func dayOnlyDateFromDate(from: Date) -> Date {
        return DateUtils.dateFromString(from: DateUtils.dayStringFromDate(from: from))
    }

    static func dayStringFromDate(from: Date) -> String {
        return String(
            DateUtils
                .formattedStringFromDate(from: from)
                .split(separator: "T")[0]
        )
    }

    static func formattedStringFromDate(from: Date) -> String {
        DateUtils.dateFormatter.dateStyle = .medium
        DateUtils.dateFormatter.timeStyle = .none
        DateUtils.dateFormatter.locale = Locale(identifier: "en_US")
        
        return DateUtils.dateFormatter.string(from: from)
    }
    static func sortedDateArray(from: [Date], descending: Bool = true) -> [Date] {
        return from
            .map { DateUtils.formattedStringFromDate(from: $0) }
            .sorted { descending ? $0 < $1 : $1 < $0 }
            .map { DateUtils.dateFromString(from: $0) }
    }
}
