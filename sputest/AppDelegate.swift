//
//  AppDelegate.swift
//  sputest
//
//  Created by Chi Kim on 1/19/24.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
	let autoUpdateManager = AutoUpdateManager.shared

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		if let button = statusItem.button {
			button.title = "Sparkle"
		}
		NSApp.setActivationPolicy(.accessory)
		let menu = NSMenu()
		let defaults = UserDefaults.standard
		autoUpdateManager.preRelease = defaults.bool(forKey:"preRelease")
		let preReleaseMenuItem = NSMenuItem(title: "Pre-release", action: #selector(togglePreRelease(_:)), keyEquivalent: "")
		preReleaseMenuItem.state = (autoUpdateManager.preRelease) ? .on : .off
		menu.addItem(preReleaseMenuItem)
		menu.addItem(NSMenuItem(title: "Check for Updates", action: #selector(checkForUpdates(_:)), keyEquivalent: ""))
		menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
		statusItem.menu = menu
		let windows = NSApplication.shared.windows
		NSApplication.shared.hide(nil)
		windows[1].close()
	}

	@objc func togglePreRelease(_ sender: NSMenuItem) {
		sender.state = (sender.state == .off) ? .on : .off
		autoUpdateManager.preRelease = sender.state == .on
		let defaults = UserDefaults.standard
		defaults.set(autoUpdateManager.preRelease, forKey:"preRelease")
	}

	@objc func checkForUpdates(_ sender: NSMenuItem) {
		AutoUpdateManager.shared.checkForUpdates()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
		return true
	}


}

