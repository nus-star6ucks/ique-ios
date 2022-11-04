//
//  TicketDetailView.swift
//  ique
//
//  Created by PCDotFan on 2022/11/2.
//

import SwiftUI
import SwiftUIRouter
import EasySkeleton

struct TicketDetailView: View {
    
    var ticketId: String
    
    init(ticketId: String) {
        self.ticketId = ticketId
    }
    
    @EnvironmentObject private var navigator: Navigator
    
    @State var store: StoreDetail = StoreDetail(id: 0, address: "", merchantId: 0, name: "Loading", type: "Loading", status: "Loading", registerTime: Date.now, resources: StoreResources(description: "Loading", imageUrl: "", ratings: 0), phoneNumbers: [], seatTypes: [], queuesInfo: [])
    
    @State var ticket: TicketDetail = TicketDetail(customerId: 0, endTime: Date.now, queueInfo: QueueInfo(seatType: SeatType(name: "none")), queueNumber: 0, startTime: Date.now, status: "", storeId: 0, id: 0)
    
    @State private var isLoading = true
    
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
                                    .font(.system(size: 16))
                                    .foregroundColor(.primary)
                            }
                            .clipped()
                            .cornerRadius(4)
                            .padding()
                            .onTapGesture {
                                navigator.goBack()
                            }
                        Spacer()
                        Text("You are Queueing")
                            .fontWeight(.semibold)
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
                            .font(.title)
                            .fontWeight(.bold)
                            .skeletonable()
                            .skeletonCornerRadius(8)
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
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                                .padding(.top, 12)
                            
                            Text((ticket.queueInfo.waitingSize - 1) == 0 ? "You are Next!" : String(ticket.queueNumber))
                                .foregroundColor(primaryColor)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .padding(.vertical, 12)
                                .padding(.top, -12)
                                .skeletonable()
                                .skeletonCornerRadius(8)
                        }
                            .padding(12)
                        HStack(spacing: 8) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Type")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                Text(String(ticket.queueInfo.seatType?.name ?? ""))
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .font(.headline)
                                    .skeletonable()
                                    .skeletonCornerRadius(8)
                                    
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Ahead")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                Text(String(ticket.queueInfo.waitingSize - 1) + " group(s)")
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .font(.headline)
                                    .skeletonable()
                                    .skeletonCornerRadius(8)
                                    
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Estimated Time")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                Text(String(ticket.queueInfo.estimateWaitingTime) + " mins")
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                    .font(.headline)
                                    .skeletonable()
                                    .skeletonCornerRadius(8)
                                    
                            }
                        }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 24)
                        
                    }
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(8)
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("· Please ensure everyone is present when queue number is called.")
                            .fontWeight(.light)
                            .lineLimit(nil)
                        Text("· Ticket will not be valid if ticket exceeds 3 number or above.")
                            .fontWeight(.light)
                        Text("· Dine-in is for up to groups of 5 fully vaccinated persons only.")
                            .fontWeight(.light)
                        Text("· For iOS users, please kindly take a screenshot of this page.")
                            .fontWeight(.light)
                    }
                    .padding(.horizontal, 24)
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color.gray)
                }
    
                
                Spacer()
            }
                .onAppear {
                    Task {
                        do {
                            self.isLoading = true
                            
                            let ticket = try await getTicketDetail(ticketId: ticketId)
                            self.ticket = ticket
                            
                            let store = try await getStoreDetail(storeId: String(ticket.storeId))
                            self.store = store
                            
                        } catch {
                            navigator.navigate("/auth", replace: true)
                        }
                        self.isLoading = false
                    }
                }
                .setSkeleton($isLoading)
            Spacer()
                .frame(height: 108)
                .clipped()
        }
    }
}

struct TicketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TicketDetailView(ticketId: "130")
    }
}
