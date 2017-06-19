#!/bin/bash

echo "Developed by Benedict Charles"
echo "Twitter @@virgil_cj"

if [[ $EUID -ne 0 ]]; then
   echo " [!]This script must be run as root" 1>&2
   exit 1
fi

IFS='/' read -a array <<< pwd

version=$( lsb_release -r | grep -oP "[0-9]+" | head -1 )
 
if lsb_release -d | grep -q "Kali"; then
	Release=Kali
	echo "Preparing to install"
else
	echo "Please run in only Kali Linux_x64"


fi

rm /etc/apt/sources.list
echo deb http://http.kali.org/kali kali-rolling main non-free contrib > /etc/apt/sources.list
echo deb-src http://http.kali.org/kali kali-rolling main non-free contrib >> /etc/apt/sources.list
echo deb http://old.kali.org/kali sana main non-free contrib >> /etc/apt/sources.list

#adding 32bit architecture
dpkg --add-architecture i386
apt-get -y update
apt-get -y install wine
apt-get -y install wine-bin
apt-get -y install mingw32
msfupdate
cd ~/Downloads/
mkdir tools
cd tools/

echo "[+][+]Installing Sublist3r: subdomain bruteforcer"
git clone https://github.com/aboul3la/Sublist3r
cd Sublist3r/
pip install -r requirements.txt

echo "[+][+]Installing Brutespray: Default password bruteforcer"
cd ~/Downloads/tools/
git clone https://github.com/x90skysn3k/brutespray

echo "[+][+]Installing CrackMapExec"
cd ~/Downloads/tools/
apt-get -y install crackmapexec

echo "[+][+]Installing Powershell-Empire"
cd ~/Downloads/tools/
git clone https://github.com/EmpireProject/Empire
cd Empire/setup/
chmod +x install.sh
./install.sh

echo "[+][+] Downloading and adding path for EternalBlue metasploit"
cd /usr/share/metasploit-framework/modules/exploits/windows/smb/
wget https://raw.githubusercontent.com/rapid7/metasploit-framework/master/modules/exploits/windows/smb/ms17_010_eternalblue.rb

echo "[+][+]Installing BEWgor: wordlist generator for targetted attacks"
cd ~/Downloads/tools/
git clone cd ~/Downloads/tools/

echo "[+][+]Installing psychoPATH: LFI/RFI detector with BurpSuite"
cd ~/Downloads/tools/
git clone https://github.com/ewilded/psychoPATH

echo "[+][+]Downloading MimiPenguin"
cd ~/Downloads/tools/
git clone https://github.com/huntergregal/mimipenguin

echo "[+][+] Downloading MiMikatz JS"
cd ~/Downloads/tools/
mkdir mimikatz_JS
cd mimikatz_JS/
wget https://gist.githubusercontent.com/subTee/b30e0bcc7645c790fcd993cfd0ad622f/raw/2adcc9d2570b4367c6cc405e5a5969863d04fc9b/katz.js


echo "[+][+] Downloading EyeWitness"
cd ~/Downloads/tools/
git clone https://github.com/ChrisTruncer/EyeWitness
cd EyeWitness/setup/
chmod +x setup.sh
./setup.sh

echo "[+][+] Downloading Dirs3arch- Web directory bruteforcer"
cd ~/Downloads/tools/
git clone https://github.com/maurosoria/dirsearch

echo "[+][+] Downloading CMSmap: CMS web scanner"
cd ~/Downloads/tools/
git clone https://github.com/Dionach/CMSmap


echo "[+][+] Installing MITMf by @@byt3bl33d3r"
apt-get -y install python-dev python-setuptools libpcap0.8-dev libnetfilter-queue-dev libssl-dev libjpeg-dev libxml2-dev libxslt1-dev libcapstone3 libcapstone-dev libffi-dev file

pip install virtualenvwrapper
updatedb
source $(locate virtualenvwrapper.sh)
mkvirtualenv MITMf -p /usr/bin/python2.7
cd ~/Downloads/tools/
git clone https://github.com/byt3bl33d3r/MITMf
cd MITMf/ && git submodule init && git submodule update --recursive
pip install -r requirements.txt

echo "[+][+][+][+]Your Kali Linux is now Ready[+][+][+][+]"
