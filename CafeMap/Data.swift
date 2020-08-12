//
//  Data.swift
//  PhotowallAPI
//
//  Created by guowei on 2020/8/12.
//  Copyright © 2020 guowei. All rights reserved.
//

import Foundation

struct CafeInfo:Codable{
    let name:String
    let address:String
    let limited_time:String
    let latitude:String
    let longitude:String
    let open_time:String
}
