//
//  ViewObserver.swift
//  
//
//  Created by Bezaleel Ashefor on 11/06/2024.
//

import Foundation
import SwiftUI


class ViewObserver: ObservableObject{
    
    @Published var selectedPanel : Int = 0
//    @Published var changelogResult : ChangelogResult = ChangelogResult.init(status: 200, method: "GET", message: "success", data: DataClass.init(page: 1, pages: 2, count: 1, changelogs: []))
    
}
