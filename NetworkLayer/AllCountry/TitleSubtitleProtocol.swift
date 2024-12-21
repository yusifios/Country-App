//
//  TitleSubtitleProtocol.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 12.12.24.
//

import Foundation
protocol TitleSubtitleProtocol {
    var titleString: String {get}
    var subtitleString: String {get}
    var iconURL: String {get}
    var latlng: [Double]? { get }
}
