//
//  AuthScreenRoute.swift
//  AltJellyfin
//
//  Created by Aleksey Mironov on 18.06.2024.
//

import Foundation

protocol AuthScreenRoute {
    func showAuthScreenScene()
}

extension AuthScreenRoute where Self: RouterProtocol {
    func showAuthScreenScene() {
        let transition = WindowNavigationTransition()
        
        let module = AuthScreenModule(
            assembler: DefaultAssembler.shared,
            transition: transition
        )
        open(module.view, transition: transition)
    }
}
