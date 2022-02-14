
import SwiftUI


struct PersonView: View {
    @State private var showOverlay = false
    @State private var titleBanner = "Error"
    @State private var messageBanner = ""
    
    var person: Speaker
    
    init (person: Speaker) {
        self.person = person
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    HStack {
                        Text(person.fields.name)
                            .font(.title)
                            .foregroundColor(Color("white"))
                        if (person.fields.status != nil && person.fields.status == "Confirmed") {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    
                    Text(person.fields.type)
                        .font(.subheadline)
                        .foregroundColor(Color("white"))
                }
                
                Divider()
                
                Text("About")
                    .font(.title2)
                    .foregroundColor(Color("white"))
                
                Group {
                    HStack {
                        Text("\(person.fields.role)")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(Color("white"))
                        
                        Text("at:")
                            .font(.body)
                            .foregroundColor(Color("white"))
                    }
                    
                    Text("\(person.fields.company[0])")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color("white"))
                    
                }
                
                Divider()
                
                if (person.fields.type == "Speaker") {
                    Text("Contact")
                        .font(.title2)
                        .foregroundColor(Color("white"))
                    
                    Group {
                        HStack {
                            Text("Email: ").font(.body).foregroundColor(Color("white"))
                            Text(person.fields.email!).font(.body)
                            .foregroundColor(Color("white"))
                        }
                        
                        HStack {
                            Text("Tel.: ").font(.body).foregroundColor(Color("white"))
                            Text(person.fields.phone!).font(.body)
                            .foregroundColor(Color("white"))
                        }
                    }
                }
            }
            .padding()
        }}
        .navigationTitle(person.fields.name)
        .navigationBarTitleDisplayMode(.inline)
        // Banner notification
        .overlay(overlayView: Banner.init(data: Banner.BannerDataModel(title: titleBanner, detail: messageBanner, type: .error), show: $showOverlay)
                 , show: $showOverlay)
        .onAppear(perform: {
            ApiService.call(Sponsor.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors/\(person.fields.company[0])") { (data) in
                
            } errorHandler: { (error) in
                
                withAnimation { () -> Void in
                    switch (error) {
                    case .none:
                        break
                    case .some(.apiError(_, _)):
                        self.messageBanner = "An issue occured when querying the API"
                        break
                    case .some(.httpError(_)):
                        self.messageBanner = "We couldn't reach the API"
                        break
                    case .some(.parseError(_, _)):
                        self.messageBanner = "An issue occured while parsing the data"
                        break
                    }
                    
                    self.showOverlay = true
                }
            }
        })
    }
}


