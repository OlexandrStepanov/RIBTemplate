# Description
This folder has XCode template for convenient creation of a new RIB module in a project.
Each RIB module consist of next entities:

* *Builder* which confirms to *RIBBuilder* protocol
* *Router* which is subclass of *RIBRouter*
* *Interactor* which confirms to *RIBInteractor* protocol
* *ViewController* which confirms to *RIBViewController* protocol

# Installation

* Make a new folder if deosn't exist on path:
~/Library/Developer/Xcode/Templates/Custom/
* Copy RIB.xctemplate in the folder above
* Restart XCode

# Usage

* Use "New File" action either from Project navigator panel either from "File" -> "New" menu in top bar.
* In the opened popup scroll down to the "Custom" section and select "RIB module" item
* Provide name of the new module, which will be used as prefix for new classes
