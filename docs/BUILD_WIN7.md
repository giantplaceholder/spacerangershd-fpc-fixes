## Windows 7 build requirements

**NB: These instructions below were hand-tested on a squeaky clean freshly installed Windows 7 SP1 VM. If you do not follow them to the letter and something breaks during your build - do not open an issue in this repo.**

#### 1) KB2533623 and KB2999226 should be installed

First one is a bit obscure and was removed from Microsoft website. The most proper way would be to use a copy available via Archive.org:

https://web.archive.org/web/20110711000000id_/https://download.microsoft.com/download/F/1/0/F106E158-89A1-41E3-A9B5-32FEB2A99A0B/Windows6.1-KB2533623-x64.msu

Second one is still freely available via Microsoft: https://www.microsoft.com/en-US/download/details.aspx?id=49093

Those are required by Python 3.14 installer and some of the libraries of WinLibs package (not all of them are built as MSVCRT only).

#### 2) System should have a current CA certificate store

Windows 7 central authority store is outdated - meaning it does not know about some of the newer CAs, and by extension, client certificates issued by them. This may and probably will cause some issues during deps' download.

To fix this, do exactly these steps:

*  Download a file: https://curl.se/ca/cacert.pem
*  Create a new directory: ```C:\ProgramData\ca-certificates```
*  Put cacert.pem file in this directory
*  Launch terminal from admin (right-click on it in Start menu, then select Run as administrator)
*  Execute exactly these commands:
```
setx /M SSL_CERT_FILE "C:\ProgramData\ca-certificates\cacert.pem"
setx /M CURL_CA_BUNDLE "C:\ProgramData\ca-certificates\cacert.pem"
```
* Reboot

#### 3) Python 3.10+ should be installed

You will have to install a third-party version of Python 3.14 that still can run on Windows 7. The last official Python version to run on Windows 7 is 3.8, and build scripts were written with at least 3.10 in mind.

Download it from this link: https://github.com/Alex313031/Python-Win7/raw/refs/heads/master/3.14.5/python-3.14.5-amd64-full.exe and install as usual. If you forgot to install either of the KB patches, it will remind you.

#### 4) A supported version of Git for Windows should be installed

Download it from this link: https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/Git-2.46.2-64-bit.exe

This is the last official version of Git for Windows that supports Windows 7.

#### 5) Done!

Once you complete everything from above, you can proceed building the project as usual.