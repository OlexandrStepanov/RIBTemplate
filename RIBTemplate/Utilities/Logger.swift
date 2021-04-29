//
//  Logger.swift
//  Sirius
//
//  Created by Oleksandr Stepanov on 8/5/19.
//  Copyright © 2019 Kromtech. All rights reserved.
//

import Foundation

class Logger {

	open class func debug(_ message: String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        print("ℹ️\(functionName)(\(fileName):\(lineNumber)---\(message)")
	}

	open class func warning(_ message: String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        print("⚠️\(functionName)(\(fileName):\(lineNumber)---\(message)")
	}

	open class func error(_ message: String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        print("❗️\(functionName)(\(fileName):\(lineNumber)---\(message)")
	}
}
