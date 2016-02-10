OpenShift All-In-One Virtual Machine
====================================
Get Origin Up and Running From the Comfort of Your Own Laptop

This image is based off of OpenShift Origin and is a fully functioning OpenShift instance with an integrated Docker registry. The
intent of this project is to allow Web developers and other interested parties to run OpenShift V3 on their own computer. Given the
way it is configured, the VM will appear to your local machine as if it was running somewhere off the machine.
 
The OpenShift Master, Node, Docker Registry, and other pieces are running in one VM. Given it's focus on application developers, it
should NOT be used in production. While the Vagrantfile only specifies 2 gigs of RAM, you can edit the file to increase this setting
if you want to run more containers concurrently in your instance.


Option 1 - Install on your machine
----------------------------------
1. [Download and unzip.](https://github.com/eschabell/openshift-orign-demo/archive/master.zip)

2. Run 'init.sh' file.

3. Read and follow displayed instructions and enjoy OpenShift on your local machine!

Note: after a run of the demo installation, you will have a Vagrant enviornment installed
based on openshift-install-demo. To re-run this demo install again, see output instructions
to remove previous entries to avoid errors.

Supporting Articles
-------------------
- coming soon...


Released versions
-----------------
See the tagged releases for the following versions of the product:

- v1.0 - based on Openshift Vagrant box 1.1.1.

