//
//  SignInRepository.swift
//  PiggyBank
//

protocol SignInRepository {
    func signIn(request: DomainSignInModel, completion: @escaping (Result<DomainAuthModel>) -> Void)
}
