//
//  SignInDataRepository.swift
//  PiggyBank
//

protocol SignInDataSource {
    func signIn(request: DomainSignInModel, completion: @escaping (Result<DomainAuthModel>) -> Void)
}

class SignInDataRepository: SignInRepository {
    private let remoteDataSource: SignInDataSource?

    init(remoteDataSource: SignInDataSource?) {
        self.remoteDataSource = remoteDataSource
    }

    func signIn(request: DomainSignInModel, completion: @escaping (Result<DomainAuthModel>) -> Void) {
        remoteDataSource?.signIn(request: request, completion: completion)
    }

}
