//
//  UserCredentialsRepository.swift
//  PiggyBank
//

protocol UserCredentialsRepository {
    func saveUserCredentials(domainModel: DomainUserCredentialsModel, completion: @escaping (Result<Void>) -> Void)
    func deleteUserCredentials(completion: @escaping (Result<Void>) -> Void)
    func getUserCredentials(completion: @escaping (Result<DomainUserCredentialsModel?>) -> Void)
}
