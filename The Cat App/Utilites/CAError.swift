//
//  CAError.swift
//  The Cat App
//
//  Created by ahmed sultan on 26/10/2021.
//

import Foundation

enum CAError: String, Error {
    
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid, Please try again later."
    case invalidUrl = "There is something goes wrong, please try again later."
    case newworkNotReachable = "No internet connection, please check your connection ad try again later."

}
