//
//  TicketsView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import Alamofire
struct TicketsView: View {
    
    @State var stores: [StoreItem] = []
    
    var body: some View {
        VStack {
            Text("Hello")
            List {
                ForEach(stores, id: \.id) { store in
                    Text(store.name)
                }
            }
                .onAppear {
                    AF
                        .request("https://ique.vercel.app/api/stores/list")
                        .validate(statusCode: 200..<300)
                        .responseDecodable(of: [StoreItem].self) { response in
                            debugPrint(response)
                            switch response.result {
                                case .success(let storeItems):
                                    self.stores = storeItems
                                case .failure(let error):
                                    print("error", error.localizedDescription)
                            }
                        }
                }
        }
 
    }
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView()
    }
}
