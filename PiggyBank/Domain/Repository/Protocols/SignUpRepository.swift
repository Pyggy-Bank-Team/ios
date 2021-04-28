//
//  SignUpRepository.swift
//  PiggyBank
//

protocol SignUpRepository {
    func signUp(request: DomainSignUpModel, completion: @escaping (Result<DomainAuthModel>) -> Void)
}
