//
//  ManagerOfMarkers.swift
//  Browser
//
//  Created by Alexandr Kulya on 27.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import Foundation

class ManagerOfMarkers {
    var markersCount : Int {
        return markers.count
    }
    var markers: [Marker] = []
    func add(marker: Marker) {
        markers.append(marker)
    }
}
