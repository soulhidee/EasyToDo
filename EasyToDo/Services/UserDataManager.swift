import Foundation
import UIKit

final class UserDataManager {
    // MARK: - Constants
    enum UserDataManagerConstants {
        static let compressionQuality = 0.5
    }
    
    static let shared = UserDataManager()
    private init() {}
    
    // MARK: - Save / Load User Name
    func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: Constants.userNameKey)
    }
    
    func loadUserName() -> String? {
        UserDefaults.standard.string(forKey: Constants.userNameKey)
    }
    
    // MARK: - Save / Load Profile Image
    func saveProfileImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: UserDataManagerConstants.compressionQuality) else { return }
        let url = getDocumentsDirectory().appendingPathComponent(Constants.profileImageFileName)
        try? data.write(to: url)
    }
    
    func loadProfileImage() -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(Constants.profileImageFileName)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
    
    // MARK: - Authorization Status
    func setUserAuthorized(_ authorized: Bool) {
        UserDefaults.standard.set(authorized, forKey: Constants.isUserAuthorizedKey)
    }
    
    func isUserAuthorized() -> Bool {
        UserDefaults.standard.bool(forKey: Constants.isUserAuthorizedKey)
    }
    
    // MARK: - Helpers
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[.zero]
    }
}
