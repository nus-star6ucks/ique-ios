//
//  StoreDetailView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import AlertKit
import Alamofire
import SwiftUIRouter
import EasySkeleton

struct StoreDetailView: View {
    
    var storeId: String
    
    init(storeId: String) {
        self.storeId = storeId
    }
    
    @EnvironmentObject private var navigator: Navigator
    @StateObject var alertManager = AlertManager()
    
    @State var store: StoreDetail = StoreDetail(id: 0, address: "", merchantId: 0, name: "Loading", type: "Loading", status: "Loading", registerTime: Date.now, resources: StoreResources(description: "", imageUrl: "", ratings: 0), phoneNumbers: [], seatTypes: [], queuesInfo: [])
    
    @State var tickets: [TicketItem] = []

    @State private var isLoading = true
    
    var body: some View {
        
            ZStack {
                Color.gray.opacity(0.06).edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
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
                            Text(store.name)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            Spacer()
                            Rectangle()
                                .frame(width: 32, height: 32)
                                .padding()
                                .opacity(0)
                        }
                        .padding(.horizontal, 2)
                    }
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, minHeight: 300, alignment: .top)
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
                    .mask {
                        Rectangle()
                    }
                    .cornerRadius(12)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .firstTextBaseline) {
                            Text(store.name)
                                .font(.title)
                                .bold()
                                .skeletonable()
                                .skeletonCornerRadius(8)
                            Spacer()
                            HStack(alignment: .firstTextBaseline, spacing: 3) {
                                Image(systemName: "star")
                                    .foregroundColor(.orange)
                                Text(String(store.resources.ratings))
                            }
                            .font(.system(size: 16, weight: .regular))
                        }
                    }
                        .padding(.horizontal, 24)
                        .padding(.vertical)
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Text(store.resources.description)
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineSpacing(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .clipped()
                                .skeletonable()
                                .skeletonCornerRadius(8)
                        }
                        .padding()
                        HStack {
                            VStack(alignment: .leading) {
                                Text(store.address)
                                    .font(.subheadline.weight(.semibold))
                                    .skeletonable()
                                    .skeletonCornerRadius(8)
                                Text(store.type)
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                    .skeletonable()
                                    .skeletonCornerRadius(8)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .clipped()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background {
                            RoundedRectangle(cornerRadius: 0, style: .continuous)
                                .fill(Color(.systemGray6))
                        }
                    }
                        .clipped()
                        .background {
                            Rectangle()
                                .fill(Color(.systemGray6))
                        }
                        .mask {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                        }
                        .padding(.horizontal, 12)
                        .padding(.bottom, 12)
                    
                    if (!store.queuesInfo.filter { $0.queueId > 0 }.isEmpty) {
                        VStack(spacing: 0) {
                            Text("Select a Queue….")
                                .frame(alignment: .leading)
                                .clipped()
                                .padding(.leading)
                                .foregroundColor(Color(.tertiaryLabel))
                                .padding(.top)
                            Divider()
                                .padding(.top)
                                .opacity(0.5)
                            VStack(spacing: 0) {
                                ForEach(store.queuesInfo.filter { $0.queueId > 0 }, id: \.queueId) { q in
                                    HStack(alignment: .firstTextBaseline) {
                                        Text(q.seatType?.name ?? "")
                                            .font(.body)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        HStack(spacing: 2) {
                                            Image(systemName: "person")
                                                .frame(width: 20)
                                                .clipped()
                                            Text(String(q.waitingSize))
                                            if let ticket = tickets.first(where: {$0.queueId == q.queueId}) {
                                                Button("Go to Ticket") {
                                                    navigator.navigate("/tickets/" + String(ticket.ticketId))
                                                }
                                                    .padding(.vertical, 4)
                                                    .padding(.horizontal, 8)
                                                    .foregroundColor(Color.white)
                                                    .background(primaryColor)
                                                    .cornerRadius(4)
                                                    .clipped()
                                                    .padding(.leading)
                                            } else {
                                                Button("Queue!") {
                                                    alertManager.show(primarySecondary: .info(
                                                            title: "Request Ticket Confirmation",
                                                            message: "You're requesting to queue \(q.seatType?.name ?? ""). There are \(q.waitingSize) group(s) waiting in front of you, expect to wait \(q.estimateWaitingTime) min(s).",
                                                            primaryButton: Alert.Button.destructive(Text("OK")) {
                                                                Task {
                                                                    do {
                                                                        let ticket = try await queue(queueId: +q.queueId, storeId: +store.id)
                                                                        navigator.navigate("/tickets/" + String(ticket.ticketId))
                                                                    } catch {
                                                                        debugPrint(error)
                                                                    }

                                                                }
                                                    },
                                                            secondaryButton: Alert.Button.cancel()))

                                                }
                                                    .padding(.vertical, 4)
                                                    .padding(.horizontal, 8)
                                                    .foregroundColor(Color.white)
                                                    .background(primaryColor)
                                                    .cornerRadius(4)
                                                    .clipped()
                                                    .padding(.leading)
                                            }
                                        }
                                        .foregroundColor(Color.gray)

                                    }
                                        .padding(.vertical)
                                        .background(alignment: .bottom) {
                                            Divider()
                                                .opacity(0.25)
                                        }
                                        .padding(.horizontal)
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                            .clipped()
                            .background {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color(.systemBackground))
                            }
                            .padding(.horizontal, 12)
                    }

                        

                    Spacer()
                }
                    .onAppear {
                        Task {
                            do {
                                self.isLoading = true
                                
                                let store = try await getStoreDetail(storeId: storeId)
                                self.store = store
                                
                                let tickets = try await getTickets()
                                self.tickets = tickets
                                
                            } catch {
                                navigator.navigate("/auth", replace: true)
                            }
                            
                            self.isLoading = false
                        }
                    }
                    .uses(alertManager)
                    .setSkeleton($isLoading)
            }.ignoresSafeArea()
        
    }
}

struct StoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailView(storeId: "240")
    }
}

