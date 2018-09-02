//
//  AENetworking.swift
//  ApiECHO
//
//  Created by Vitaly Plivachuk on 8/30/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import Foundation

public class AENetworking {
    
    public init(sessionConfiguration:URLSessionConfiguration) {
        self.urlSession = URLSession(configuration: sessionConfiguration)
    }
    
    private static let apiHost = "apiecho.cf"
    private static let apiPath = "api"
    private static let apiGetPath = "get"
    private let useSecureConnention = true
    private var basicComponents:URLComponents {
        var components = URLComponents()
        components.scheme = useSecureConnention ? "https" : "http"
        components.host = AENetworking.apiHost
        return components
    }
    
    var urlSession:URLSession
    
    public enum ApiMethod:String{
        case login
        case logout
        case signup
        case text
        
        func getPath() -> String{
            let basicPath = "/\(apiPath)"
            let aditionalPath:String?
            switch self {
            case .text:
                aditionalPath = AENetworking.apiGetPath
            default:
                aditionalPath = nil
            }
            return [basicPath, aditionalPath, self.rawValue].compactMap{return $0}.joined(separator: "/").appending("/")
        }
    }
    
    public enum HTTPMethod:String{
        case post = "POST"
        case get = "GET"
    }
    
    public enum AENetworkingError:Error{
        case urlCreation
        case emptyData
        case unknownError
    }
    
    public func configureAuth(with user:AEUserModel){
        let authValue: String = "Bearer \(user.token)"
        let config = urlSession.configuration
        
        config.httpAdditionalHeaders = ["authorization": authValue]
        urlSession = URLSession(configuration: config)
    }
    
    public func createUrl(for method:ApiMethod) throws -> URL{
        var components = basicComponents
        components.path = method.getPath()
        guard let url = components.url else {throw AENetworkingError.urlCreation}
        return url
    }
    
    private func make<Resp:AEResponseModel>(request:URLRequest, for modelType:Resp.Type, completion: @escaping (Resp?,Error?)->()){
        urlSession.dataTask(with: request) { data, response, error in
            do{
                if let error = error {throw error}
                guard let data = data else {throw AENetworkingError.emptyData}
                let responseModel = try JSONDecoder().decode(AEPostResponseModel<Resp>.self, from: data)
                if let error = responseModel.errors?.first{
                    throw error
                } else if responseModel.success, let model = responseModel.data{
                    completion(model, nil)
                } else {
                    throw AENetworkingError.unknownError
                }
            } catch let error{
                completion(nil,error)
            }
            }.resume()
    }
    
    public func post<Req:AERequestModel, Resp:AEResponseModel>(_ requestModel:Req, respType:Resp.Type, url:URL, completion: @escaping (Resp?,Error?)->()){
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            let data = try JSONEncoder.init().encode(requestModel)
            request.httpBody = data
            make(request: request, for: Resp.self) { model, error in
                completion(model,error)
            }
        } catch let error{
            completion(nil,error)
        }
    }
    
    public func get<Resp:AEResponseModel>(_ respType:Resp.Type, url:URL, completion: @escaping (Resp?,Error?)->()){
        let request = URLRequest(url: url)
        make(request: request, for: Resp.self) { model, error in
            completion(model,error)
        }
    }
    
    public class AEPostResponseModel<Model:Codable>: Codable{
        convenience public required init(from decoder: Decoder) throws{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let success = try container.decode(Bool.self, forKey: .success)
            let errors = try container.decodeIfPresent([AEError].self, forKey: .errors)
            
            let data: Model?
            do{
                data = try container.decodeIfPresent(Model.self, forKey: .data)
            } catch {
                data = nil
            }
            self.init(success: success, errors: errors, data: data)
        }
        
        init(success:Bool, errors:[AEError]?, data:Model?) {
            self.success = success
            self.data = data
            self.errors = errors
        }
        let success: Bool
        let errors: [AEError]?
        let data: Model?
    }
}
