OpenShift Install Demo for Private PaaS
=======================================
Get Origin Up and Running From the Comfort of Your Own Laptop

This image is based off of OpenShift Origin and is a fully functioning OpenShift instance with an integrated Docker registry. The
intent of this project is to allow Web developers and other interested parties to run OpenShift V3 on their own computer. Given the
way it is configured, the VM will appear to your local machine as if it was running somewhere off the machine.
 
The OpenShift Master, Node, Docker Registry, and other pieces are running in one VM. Given it's focus on application developers, it
should NOT be used in production. While the Vagrantfile only specifies 2 gigs of RAM, you can edit the file to increase this setting
if you want to run more containers concurrently in your instance.


Option 1 - Install on your machine
----------------------------------
1. [Download and unzip.](https://github.com/eschabell/openshift-install-demo/archive/master.zip)

2. Run 'init.sh' or 'init.bat' file. 'init.bat' must be run with Administrative privileges.

3. Read and follow displayed instructions and enjoy OpenShift on your local machine!

Note: after a run of the demo installation, you will have an entry in both the Vagrant registry
and the VirtualBox registry. If you re-run the demo install, we have placed error handling to clean
it up before re-installing. Just watch the output for details.

When running on Windows, Vagrant may fail retrieving the OpenShift origin box. If this occurs, you will need to download the Microsoft Visual C++ Redistribute Package. Click [here](https://www.microsoft.com/en-us/download/confirmation.aspx?id=8328) to download

The default installation used settings in Vagrant file for 8GB of memory, you can change this before
running installation in support/Vagrantfile.


Supporting Articles
-------------------
- [How to install OpenShift as your private PaaS](http://www.schabell.org/2016/02/howto-install-openshift-private-paas.html)


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.1 - based on Openshift Vagrant box 1.1.1 and Windows installation.

- v1.0 - based on Openshift Vagrant box 1.1.1.

![OpenShiftOrigin](https://github.com/eschabell/openshift-install-demo/blob/master/docs/demo-images/openshift-origin.png?raw=true)

![Install 1](https://github.com/eschabell/openshift-install-demo/blob/master/docs/demo-images/install-1.png?raw=true)

![Install 2](https://github.com/eschabell/openshift-install-demo/blob/master/docs/demo-images/install-2.png?raw=true)
