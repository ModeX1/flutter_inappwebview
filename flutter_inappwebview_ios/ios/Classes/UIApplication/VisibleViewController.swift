//
//  VisibleViewController.swift
//  flutter_inappwebview
//
//  Created by Alexandru Terente on 02.08.2023.
//

import UIKit

extension UIApplication {
    var rootViewController: UIViewController? {
        return self
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?
            .rootViewController
    }
    var visibleViewController: UIViewController? {
        guard let rootViewController = self.rootViewController else {
            return nil
        }
        return getVisibleViewController(rootViewController)
    }

    private func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController? {
        if let presentedViewController = rootViewController.presentedViewController {
            return getVisibleViewController(presentedViewController)
        }
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        }
        if let tabBarController = rootViewController as? UITabBarController {
            return tabBarController.selectedViewController
        }
        return rootViewController
    }
}
