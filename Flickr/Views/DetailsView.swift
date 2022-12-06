import SwiftUI

struct DetailsView: View {
    @State var flickr: FlickrViewModel?
    @ObservedObject var userState: UserState
    
    var body: some View {
        
        Form {
            Section(header: Text("Details").font(.title3)) {
                HStack(alignment: .top) {
                    VStack {
                        if self.userState.userNavigationState.imageData != nil {
                            Text(flickr?.title ?? "")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.headline)
                            Image(uiImage: self.userState.userNavigationState.imageData!)
                                .modifier(ImageModifier())
                        }
                    }.padding(10)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                Text("Author\n \(flickr?.author ?? "")")
                Text("Date taken\n \(flickr?.dateTaken ?? "")")
            }
        }
        .onAppear {
            self.userState.userNavigationState.backButtonPressedOnDetailView = true
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(userState: .init())
    }
}
