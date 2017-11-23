//
//  EmojiModel.swift
//  BWCollectionViewExample
//
//  Created by Bruno Fulber Wide on 05/08/17.
//  Copyright © 2017 BW. All rights reserved.
//

import Foundation
public class EmojiModel {
    static var `default` : EmojiModel = EmojiModel()
    
    let emojis = [ Emoji("Heart Face", image: Asset.Cinema.Slides.slide3Image3.image),
                   Emoji("Smiley Face", image: Asset.Cinema.Slides.slide3Image3.image),
                   Emoji("Space Invader", image: Asset.Cinema.Slides.slide3Image3.image),
                   Emoji("Alien", image: Asset.Cinema.Slides.slide3Image3.image) ]
    
    private init(){
        
    }
}
