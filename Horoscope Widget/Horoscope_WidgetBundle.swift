//
//  Horoscope_WidgetBundle.swift
//  Horoscope Widget
//
//  Created by Anastasio Del Toro Almansa on 08/05/2023.
//

import WidgetKit
import SwiftUI

@main
struct Horoscope_WidgetBundle: WidgetBundle {
    var body: some Widget {
        Horoscope_Widget()
        Horoscope_WidgetLiveActivity()
    }
}
