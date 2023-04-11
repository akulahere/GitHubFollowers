//
//  GFError.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 21.03.2023.
//

import Foundation

enum GFError: String, Error {
  case invalidUsername = "This username created an invalid request. Please try again."
  case unableToComplete = "Unable to complete your request. Please check your internet connection."
  case invalidResponse = "Invalid response from the server. Please try again."
  case invalidData = "The data received from the server was invalid. Please try again."
  case unableToFavorite = "There was an error favoriting this user."
  case alreadyInFavorites = "You've already favorited this user."
}
