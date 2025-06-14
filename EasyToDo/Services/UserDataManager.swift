import Foundation
import UIKit

final class UserDataManager {
    static let shared = UserDataManager()
    private init() {}
    
    func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: Constants.userNameKey)
    }
    
    func loadUserName() -> String? {
        UserDefaults.standard.string(forKey: Constants.userNameKey)
    }
    
    func saveProfileImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let url = getDocumentsDirectory().appendingPathComponent(Constants.profileImageFileName)
        try? data.write(to: url)
    }
    
    func loadProfileImage() -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(Constants.profileImageFileName)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
