import Foundation

protocol Assembler:
    ManagersAssembler,
    LaunchScreenAssembler,
    AuthScreenAssembler {
}

final class DefaultAssembler: Assembler {

    static let shared = DefaultAssembler()
}
