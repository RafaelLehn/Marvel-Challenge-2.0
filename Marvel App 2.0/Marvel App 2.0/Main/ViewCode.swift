//
//  ViewCode.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/7/24.
//

import Foundation

protocol ViewCode {
    func addSubviews()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func setup() {
        addSubviews()
        setupConstraints()
        setupStyle()
    }
}
