//
//  LoginButton.swift
//  Whatsapp
//
//  Created by user176708 on 3/5/21.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit

class LoginButton: UIButton {
    var action: (() -> Void)?

    func whenButtonIsClicked(action: @escaping () -> Void) {
        self.action = action
        self.addTarget(self, action: #selector(LoginButton.clicked), for: .touchUpInside)
    }

    // Button Event Handler:
    // I have not marked this as @IBAction because it is not intended to
    // be hooked up to Interface Builder
    @objc func clicked() {
        action?()
    }
}
