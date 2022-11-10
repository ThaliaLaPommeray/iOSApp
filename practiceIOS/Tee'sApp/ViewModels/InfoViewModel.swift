//
//  DataViewModel.swift
//  Tee'sApp
//
//  Created by La Pommeray, Thalia on 11/8/22.
//

import Foundation

class InfoViewModel {
    init(){
        manager.fetchInfo()
    }
    private let manager = NetworkManager()
    func fetchData()->[Info]{
        manager.data
    }
}
