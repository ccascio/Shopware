//
// Copyright (c) 2020 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import IQKeyboardManagerSwift
import AuthenticationServices

//-------------------------------------------------------------------------------------------------------------------------------------------------
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var loginView: Login3View!
    var feedView: Feed5View!

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

		//---------------------------------------------------------------------
		// UI initialization
		//---------------------------------------------------------------------
		window = UIWindow(frame: UIScreen.main.bounds)
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        StoreStruct.profile.id = KeychainItem.currentUserIdentifier
        appleIDProvider.getCredentialState(forUserID: StoreStruct.profile.id!) { (credentialState, error) in
            switch credentialState {
            case .authorized:

                let group: DispatchGroup =  .init()
                
                let cc = CloudController()
                group.enter()
                cc.query(tableName: "category", sortBy: "sort", filter: "", value: "", isPrivate: true) {s in
                    cc.query(tableName: "category", sortBy: "sort", filter: "", value: "", isPrivate: false) { s in
                        if s && StoreStruct.categories.filter({$0.record != nil}).count == 0 {
                            cc.saveCategories(publicRepo: false)
                        } else {
                            var i = StoreStruct.categories.count - 1
                            while i >= 0 {
                                if StoreStruct.categories[i].record == nil && StoreStruct.categories[i].checked {
                                    StoreStruct.categories[i].checked.toggle()
                                }
                                i -= 1
                            }
                        }
                        group.leave()
                    }
                }

                group.enter()
                cc.query(tableName: "scanned", sortBy: "", filter: "category", value: "Your List", isPrivate: true) { _ in
                    StoreStruct.scannedCount = StoreStruct.scanned.count
                    group.leave()
                }

                group.enter()
                cc.query(tableName: "user", sortBy: "", filter: "", value: "", isPrivate: true) { _ in
                    group.leave()
                }

                group.notify(queue: .main) {
                    DispatchQueue.main.async {
                        // Switch next 4 lines comment to view list of templates
                        self.feedView = Feed5View(nibName: "Feed5View", bundle: nil)
                        let navController = NavigationController(rootViewController: self.feedView)
//                                            self.base = BaseView(nibName: "BaseView", bundle: nil)
//                                            let navController = NavigationController(rootViewController: self.base)

                        self.window?.rootViewController = navController
                        self.window?.makeKeyAndVisible() // The Apple ID credential is valid.
                    }
                }
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                DispatchQueue.main.async {
                    self.loginView = Login3View(nibName: "Login3View", bundle: nil)
                    let navController = NavigationController(rootViewController: self.loginView)
                    self.window?.rootViewController = navController
                    self.window?.makeKeyAndVisible() // The Apple ID credential is valid.
                }
            default:
                DispatchQueue.main.async {
                    self.loginView = Login3View(nibName: "Login3View", bundle: nil)
                    let navController = NavigationController(rootViewController: self.loginView)
                    self.window?.rootViewController = navController
                    self.window?.makeKeyAndVisible() // The Apple ID credential is valid.
                }
            }
        }
        application.registerForRemoteNotifications()
		IQKeyboardManager.shared.enable = true
		IQKeyboardManager.shared.enableAutoToolbar = false

		return true
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func applicationWillResignActive(_ application: UIApplication) {

	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func applicationDidEnterBackground(_ application: UIApplication) {
        let cc = CloudController()
        cc.saveScan(publicRepo: false)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func applicationWillEnterForeground(_ application: UIApplication) {
        let cc = CloudController()
        cc.query(tableName: "scanned", sortBy: "", filter: "", value: "", isPrivate: true) {s in
//if false notify error
        }
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func applicationDidBecomeActive(_ application: UIApplication) {

	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func applicationWillTerminate(_ application: UIApplication) {
        let cc = CloudController()
        cc.saveScan(publicRepo: false)
	}
}
