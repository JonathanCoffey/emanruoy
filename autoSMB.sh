#!/bin/bash

# attempt to automatically mount SMB share to client machine w/ blank usr/pass.
mkdir ~/tk
sudo mount -t cifs -ouser="Guest",password="",rw //10.1.10.12/smb ~/tk/
echo "End of autoSMB script"
sleep 2
