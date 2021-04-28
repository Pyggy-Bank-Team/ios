//
//  SignUpDataRepository.swift
//  PiggyBank
//

protocol SignUpDataSource {
    func signUp(request: DomainSignUpModel, completion: @escaping (Result<DomainAuthModel>) -> Void)
}

class SignUpDataRepository: SignUpRepository {
    private let remoteDataSource: SignUpDataSource?

    init(remoteDataSource: SignUpDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func signUp(request: DomainSignUpModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        remoteDataSource?.signUp(request: request, completion: completion)
    }
}
