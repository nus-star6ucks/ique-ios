//
//  TicketDetailView.swift
//  ique
//
//  Created by PCDotFan on 2022/11/2.
//

import SwiftUI

struct TicketDetailView: View {
    
    @State var store: StoreDetail = StoreDetail(id: 0, address: "", merchantId: 0, name: "Luca Italian Cuisine", type: "Loading", status: "Loading", registerTime: Date.now, resources: StoreResources(description: "The beautiful range of Apple Naturalé that has an exciting mix of natural ingredients. With the Goodness of 100% Natural Ingredients", imageUrl: "https://ique.vercel.app/demo/photo.1.jpeg", ratings: 5), phoneNumbers: [], seatTypes: [], queuesInfo: [])
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.06).edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack() {
                    HStack(alignment: .center) {
                        Rectangle()
                            .frame(width: 32, height: 32)
                            .clipped()
                            .foregroundColor(Color(.systemBackground))
                            .overlay {
                                Image(systemName: "arrow.backward")
                                .foregroundColor(.primary)
                                .font(.title3)
                            }
                            .clipped()
                            .cornerRadius(4)
                            .padding()
                        Spacer()
                        Text("You are Queueing")
                            .foregroundColor(Color.white)
                        Spacer()
                        Rectangle()
                            .frame(width: 32, height: 32)
                            .padding()
                            .opacity(0)
                    }
                    .padding(4)
                }
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, maxHeight: 300, alignment: .top)
                    .clipped()
                    .background {
                        AsyncImage(url: URL(string: store.resources.imageUrl)) { image in
                             image
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                         } placeholder: {
                             ProgressView().frame(height: 300, alignment: .center)
                         }
                    }
                    .cornerRadius(12)
                    .ignoresSafeArea()
                    
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(store.name)
                            .font(.system(size: 32, weight: .semibold))
                        Spacer()
                    }
                }
                    .padding(.top, -24)
                    .padding(.horizontal, 24)
                
                VStack {
                    VStack {
                        VStack(spacing: 2) {
                            Text("Your Queue Number")
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .foregroundColor(Color.gray)
                                .padding(.top, 12)
                            Text("231")
                                .bold()
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .padding(.vertical, 12)
                        }
                            .padding(12)
                        HStack(spacing: 8) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Type")
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                Text("Super")
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .font(.title3)
                                    
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Ahead")
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                Text("1 group(s)")
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .font(.title3)
                                    
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Estimated Time")
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                Text("10 mins")
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .font(.title3)
                                    
                            }
                        }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 24)
                        
                    }
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(8)
                        .padding(12)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("· Please ensure everyone is present when queue number is called.")
                            .lineLimit(nil)
                        Text("· Ticket will not be valid if ticket exceeds 3 number or above.")
                        Text("· Dine-in is for up to groups of 5 fully vaccinated persons only.")
                        Text("· For iOS users, please kindly take a screenshot of this page.")
                    }
                    .padding(.horizontal, 24)
                    .font(.footnote)
                    .fontWeight(.light)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color.gray)
                }
                
                
                Spacer()
            }.onAppear {
                Task {
                    let store = try await getStoreDetail(storeId: 240)
                    self.store = store
                }
            }
            Spacer()
                .frame(height: 108)
                .clipped()
        }
    }
}

struct TicketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TicketDetailView()
    }
}
