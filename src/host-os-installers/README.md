# Linux Host OS installers

This directory contains the linux installers for host Linux OS-es like native 
Ubuntu or WSL Ubuntu. Execute these on a fresh OS installation to get the
system up and running for Development Container-based development quickly.

## Installing the environment on Windows


1. Clone the repository.
2. Edit the properties in install.ps1. Note: this step will be soon replaced
   with an interactive property editor.   
3. Open PowerShell
3. Execute:

       Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
       
4. Change current directory into `host-os-installers` Run the `install.ps1` script.
