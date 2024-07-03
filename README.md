# Octane: Nomba iOS SDK

The Nomba iOS SDK allows you bring the same great Nomba Checkout experience natively to your iOS apps using UIKit or SwiftUI 
Accept payments in your app by bank transfer or card

[![Platform](/platform.svg)]()
<br><br>

<p float="left">
  <img src="/ytscreens/1.png" width="24%" />
  <img src="/ytscreens/2.png" width="24%" />
  <img src="/ytscreens/3.png" width="24%" />
  <img src="/ytscreens/4.png" width="24%" /> 
</p>


<p float="left">
  <img src="/ytscreens/5.png" width="24%" />
  <img src="/ytscreens/6.png" width="24%" />
  <img src="/ytscreens/7.png" width="24%" />
  <img src="/ytscreens/8.png" width="24%" />
</p>
<br>


## 🚀 Getting Started

Use Xcode's built-in Swift Package Manager:

* Open Xcode
* Click File -> Swift Packages -> Add Package Dependency
* Paste package repository https://github.com/kudi-inc/nomba-ios-sdk.git and press return
* Import module to any file using `import Octane`

<br>



## 📖 Documentation

All of your interactions with the Nomba iOS SDK is done through a singleton, ```Octane.shared```. 
Initialise it as early as you can passing in your Nomba accountID, your Nomba ClientID and
your Nomba ClientKey (you can get this values from your Nomba Dashboard). 

### UIKit   

```
import UIKit
import Octane

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Octane.shared.configure(clientId: "clientId", accountId: "accountId", clientKey: "clientKey")
        return true
    }
    ...
}

```

### SwiftUI   

```
import SwiftUI
import Octane

struct ContentView: View {
    init() {
        Octane.shared.configure(clientId: "clientId", accountId: "accountId", clientKey: "clientKey")
    }
  
    ...
}

```


Before presenting the PaymentView, pass in details for the current payment session 

```
Octane.shared.setPaymentDetails(email: "knightbenax@gmail.com", amount: 1000, customerName: "Emeka Bond")
```


Present the PaymentView when you are ready for payment to occur

### UIKit   

```
import UIKit
import Octane

class CartViewController: UIViewController {
    ...
  
    @objc func paymentButtonTapped() {
        present(Octane.shared.viewController, animated: true)  
    }
}

```

### SwiftUI   

```
import SwiftUI
import Octane

struct ContentView: View {
    @State var isShowingPayment : Bool = false
    
    var body: some View {
        VStack{
            Button(action: {
                isShowingPayment = true
            }) {
                Text("Make Payment")
            }
        }.sheet(isPresented: $isShowingPayment){
            Octane.shared.view
        }
    }
}

```
<br>



## 📱 Projects

If you use the Nomba iOS SDK in your project and would like it listed here, simply create a new issue with the title of your app, link to it on the AppStore and tag it
with the label 'project'. It would be added here afterwards.

<br>



## 👨‍💻 Contributing

Pull requests with bugfixes and new features are much appreciated. We'll be happy to review them and merge them once they're ready, as long as they contain change that fit within the vision of Nomba's iOS SDK and provide generally useful functionality.

Clone the repository to get started working on the project.

```bash
git clone https://github.com/kudi-inc/nomba-ios-sdk
```
<br>


## ❤️ Acknowledgments

- [Drops](https://github.com/omaralbeik/Drops) is used for showing the top alerts

