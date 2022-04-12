//
//  Post.swift
//  Navigation
//
//  Created by Антон Денисюк on 16.03.2022.
//

import UIKit

struct Post {
    let author, description, image: String
    var likes, views: Int
}

var dataSource: [Post] = []
