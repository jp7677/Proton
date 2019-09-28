---
Introduction
---
Proton is a tool for use with the Steam client which allows games which are
exclusive to Windows to run on the Linux operating system. It uses Wine to
facilitate this.

Most users will prefer to use Proton provided by the Steam client itself.  The
source code is provided to enable advanced users the ability to alter
Proton.  For example, some users may wish to use a different version of Wine with
a particular title.

---
This is a stripped-down version of Proton that uses a locally installed Wine as-is. Wine must be installed into `/usr/` and every extra components like DXVK and FAudio needs to be setup manually for the desired prefixes. Note that any Steam-API usage will fail since the Wine version that comes with Proton has been patched to interact with the `steamclient` library.
