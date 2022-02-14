
import SwiftUI
import MapKit

// Extends it to make it work with MapKit pin (Requires Identifiable)
extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct ActivitiesDetails: View {
    @State private var isLoaded = false
    
    @State private var showOverlay = false
    @State private var titleBanner = "Error"
    @State private var messageBanner = ""
    
    var activity: Activity
    
    @State private var speakers: Array<Speaker> = []
    
    init(activity: Activity) {
        self.activity = activity;
    }
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    @State private var annotations: Array<CLLocationCoordinate2D> = []
    
    var body: some View {
        ZStack{
            BackgroundView()
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        Text(activity.fields.name )
                            .font(.title)
                            .foregroundColor(Color("white"))
                        
                        HStack {
                            Text(activity.fields.type )
                        }
                        .font(.subheadline)
                        .foregroundColor(Color("white"))
                    }
                    
                    Divider()
                    
                    Group {
                        Text(activity.fields.description ?? "No description for this event.").font(.body).fixedSize(horizontal: false, vertical: true).foregroundColor(Color("white"))
                    }
                    
                    Divider()
                    
                    Group {
                        Text("Starting \(activity.fields.startDate , formatter: Self.taskDateFormat)").foregroundColor(Color("white"))
                        Text("Ending \(activity.fields.endDate , formatter: Self.taskDateFormat)").foregroundColor(Color("white"))
                    }
                    
                    Divider()
                    
                    Group {
                        if (speakers.count > 0) {
                            SpeakerRow(speakers: speakers).foregroundColor(Color("white"))
                        } else {
                            Text("No speakers registered for this activity.").foregroundColor(Color("white"))
                        }
                    }
                    
                }
                .padding()
            }}
    
                                        
                       
    }
}


