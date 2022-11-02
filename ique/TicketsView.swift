//
//  TicketsView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import Alamofire
import KeychainSwift



struct TicketsView: View {
    
    @State var tickets: [TicketItem] = []
    @State var stores: [StoreItem] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.06).edgesIgnoringSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(tickets, id: \.ticketId) { ticket in
                            if let store = stores.first(where: {$0.id == ticket.storeId}) {
                                TicketCardView(imageUrl: store.resources.imageUrl, title: String(ticket.queueNumber) + " - " + ticket.seatType.name, description: store.name)
                            } else {
                            }
                        }
                    }
                    .padding(.top, 36)
                    .onAppear {
                        Task {
                            let stores = try await getStores()
                            self.stores = stores
                            
                            let tickets = try await getTickets()
                            self.tickets = tickets
                        }
                    }
                }
                .navigationTitle(Text("Tickets"))
            }

        }
    }
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView()
    }
}
