# Description

This is the iOS SDK for the expanz platform.

# Usage

## Getting Started

* Download the <a href="http://www.expanz.com/expanz-Client-SDK-for-Apple-iOS/">installer.</a>
* Open xcode and choose 'New Expanz Project'.
* Choose Product/Run.

Binary distributions for milestone and GA builds are published regularly. If you wish to build the installer from
current source, please proceed to the build instructions below.

## Training

We conduct training courses is North America, Europse, APAC & Oceania regions. Consult the expanz website for
information on when the next course in your area will be held. Alternatively it is possible to book a custom on-site
training course for 8 - 16 pax.

# Docs & Tutorials

* <a href="">Tutorials</a>
* <a href="https://github.com/expanz/expanz-iOS-SDK/wiki">Wiki</a>
* <a href="http://expanz.github.com/expanz-iOS-SDK/api/index.html">API</a>
* <a href="http://expanz.github.com/expanz-iOS-SDK/coverage/index.html">Reports</a>

# Building

## Just the Framework

Open the project in XCode and choose Product/Build.

## Command-line Build

Includes Unit Tests, Integration Tests, Code Coverge and API reports installed to Xcode.

### Requirements (one time only)

In addition to Xcode, requires the Appledoc and lcov packages. A nice way to install these is with
<a href="http://www.macports.org/install.php">MacPorts</a>.

```sh
git clone https://github.com/tomaz/appledoc.git
sudo install-appledoc.sh
sudo port install lcov
```

NB: Xcode 4.3+ requires command-line tools to be installed separately.

### Running the build (every other time)

```sh
ant
```

### Continuous Integration Builds

If you wish, you can also dowbload the 
<a href="http://expanz.github.com/expanz-iOS-SDK/installer/expanz-iOS-SDK-Installer.mkpg">
latest successful build from our continuous integration server.</a>

# Feature Requests and Contributions

. . . are very welcome.

If you're using the API shoot me an email and tell me what you're doing with it.

# Authors

* Jasper Blues - jasper.blues@expanz.com
* © 2011 - 2012 expanz.com

# LICENSE

Apache License, Version 2.0, January 2004, http://www.apache.org/licenses/

