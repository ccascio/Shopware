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

//TODO: enable FB and Twitter login
import UIKit
import AuthenticationServices

//-------------------------------------------------------------------------------------------------------------------------------------------------
class Login3View: UIViewController {

	@IBOutlet var imageViewLogo: UIImageView!
	@IBOutlet var labelSubTitle: UILabel!
    @IBOutlet weak var loginProviderStackView: UIStackView!

	//---------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProviderLoginView()
        loadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }

    /// - Tag: add_appleid_button
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }

    // - Tag: perform_appleid_password_request
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]

        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    /// - Tag: perform_appleid_request
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }


	// MARK: - Data methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func loadData() {

		imageViewLogo.image = UIImage(systemName: "person.crop.circle.badge.checkmark")
		labelSubTitle.text = "Sign in with Apple to save and retrieve your searches in full privacy"
	}

	// MARK: - User actions
	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionFacebook(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionTwitter(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionSignUp(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionLoginWithEmail(_ sender: Any) {

		print(#function)
		dismiss(animated: true)
	}
}

extension Login3View: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:

            // Create an account in your system.
            let userIdentifier = appleIDCredential.user

            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)

            CloudController().query(tableName: "user", sortBy: "", filter: "", value: "", isPrivate: true) { s in
                if s {
                    // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
                    self.saveUserPreference(appleIDCredential: appleIDCredential)

                }
            }

        case let passwordCredential as ASPasswordCredential:

            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password

            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }

        default:
            break
        }
    }

    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.cascio.social", account: "userIdentifier").saveItem(userIdentifier)
            StoreStruct.profile.id = userIdentifier
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }

    private func saveUserPreference(appleIDCredential: ASAuthorizationAppleIDCredential) {
        var profile = Profile(lastname: appleIDCredential.fullName?.familyName ?? "", firstname: appleIDCredential.fullName?.givenName ?? "")
        profile.email = appleIDCredential.email ?? ""
        StoreStruct.profile = profile
        CloudController().saveProfile()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension Login3View: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
