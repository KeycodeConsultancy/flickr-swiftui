import SwiftUI


struct ContentView: View {
    @ObservedObject private var flickrListViewModel: FlickrListViewModel
    @State private var showDetailsView = false
    @State private var flickr: FlickrViewModel?
    @State private var search: String = ""
    @State private var searchCriteria: String = "gardenning"
    @StateObject private var userState = UserState()
    @State private var imageData: UIImage?
    private let cornerRadius: CGFloat = 12
    
    init(service: ServiceProtocol)  {
        _flickrListViewModel = ObservedObject(wrappedValue: FlickrListViewModel(service: service))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Flickr search criteria", text: $searchCriteria)
                    Button("Search") {
                        Task {
                            await fetchFlickrs()
                        }
                    }
                }
                Spacer()
                detailsView()
                List(flickrListViewModel.flickrs) { flickr in
                    HStack(alignment: .top)  {
                        VStack {
                            
                            URLImage(url: flickr.media)
                                .modifier(ImageModifier())
                                .onTapGesture {
                                    showDetailsView = true
                                    self.flickr = flickr
                                    
                                    Task {
                                        self.userState.userNavigationState.imageData =  await flickr.convertNSDataToImage(url: flickr.media!)
                                    }
                                }
                        }
                        
                        VStack(alignment: .leading,
                               spacing: 8) {
                            Text(flickr.title)
                                .font(.headline)
                            ScrollView(.horizontal) {
                                Text(flickr.tags)
                            }
                        }
                    }
                }
            }.padding()
                .searchable(text: $search, prompt: "Filter on title")
                .onChange(of: search, perform: { value in
                    if !value.isEmpty && value.count >= 1 {
                        flickrListViewModel.flickrs = flickrListViewModel.flickrs.filter {
                            $0.title.lowercased().contains(value.lowercased())
                        }
                    } else {
                        Task {
                            await fetchFlickrs()
                        }
                    }
                })
                .task {
                    
                    if self.userState.userNavigationState.backButtonPressedOnDetailView == false || self.userState.userNavigationState.backButtonPressedOnDetailView == nil {
                        //do not reload view when back button is pressed from detail view
                        await fetchFlickrs()
                    }
                }
                .navigationBarTitle("Flickr")
                .navigationViewStyle(StackNavigationViewStyle())
        }
        .padding()
    }
    
    fileprivate func detailsView() -> NavigationLink<EmptyView, DetailsView> {
        return NavigationLink(destination:DetailsView(flickr: self.flickr, userState: userState), isActive: self.$showDetailsView ) {
        }
    }
    
    private func fetchFlickrs() async {
        do {
            _ = try await flickrListViewModel.fetchFlickrsWebService(searchCriteria)
        } catch {
            print(error.localizedDescription.description)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let service = LocalService()
    static var previews: some View {
        ContentView(service: service)
    }
}
