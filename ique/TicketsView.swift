//
//  TicketsView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import Alamofire
import KeychainSwift

var testToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJpcXVldWUiLCJpc3MiOiJ1bXMiLCJ1c2VyVHlwZSI6ImN1c3RvbWVyIiwiZXhwIjoxNjY3MjM0Nzc0LCJpYXQiOjE2NjcyMjkzNzQsInVzZXJJZCI6MjkyLCJqdGkiOiJiZDFkNTYwZi0wNDU4LTRmNWYtYmZjZC1hMzVkNmEyZWFhMGEiLCJ1c2VybmFtZSI6Ind3eTcwMSJ9.TOMhlTYWTdb5meV2H83snul1ULptVMtPwbx8oKIz14E"

func getTickets() async throws -> [TicketItem] {
//    let keychain = KeychainSwift()
    return try await AF
        .request("https://ique.vercel.app/api/queues/tickets?userId=292",
                 method: .get,
                 headers: [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + testToken
        ])
        .validate(statusCode: 200..<300)
        .serializingDecodable([TicketItem].self).value
}

struct TicketsView: View {
    
    @State var tickets: [TicketItem] = []
    @State var stores: [StoreItem] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(tickets, id: \.ticketId) { ticket in
                    if let store = stores.first(where: {$0.id == ticket.storeId}) {
                        TicketCardView(imageUrl: store.resources.imageUrl, title: String(ticket.queueNumber) + " - " + ticket.seatType.name, description: store.name)
                    } else {
                    }
                }
            }.onAppear {
                Task {
                    let value = try await getTickets()
                    self.tickets = value
                }
            }
            Spacer()
                .frame(height: 108)
                .clipped()
        }
        Spacer()
            .frame(height: 108)
            .clipped()
    }
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView()
    }
}
