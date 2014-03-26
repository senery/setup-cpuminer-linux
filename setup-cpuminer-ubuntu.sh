###########################################################
# Install type
# 1 : full (webmin + cpuminer + dependencies)
# 2 : no webmin install (only cpuminer + dependencies)
# 3 : install dependencies
# 4 : update live
# #########################################################
installType="1"
###########################################################
# Create Cronjob for minerd
###########################################################
workerAddCronjob="true"
###########################################################
# Worker setup
###########################################################
cpuMinerPath="/home/mine/"
workerLogin="senery"
workerStandalone="true"
workerAutostart="true"
workerPass="123"
workerUrl="stratum+tcp://stratum.scryptguild.com:3333"
workerTime=$(date +"%d%m%H%S")
printf workerName="$workerLogin"."$HOSTNAME"
printf workerCmd="$cpuMinerPath".minerd --url="$workerUrl" --user="$workerName" --pass="$workerPass"
# update repos
sudo apt-get update
# create and go to working dir
rm "$cpuMinerPath" -R
mkdir "$cpuMinerPath"
cd "$cpuMinerPath"
# WEBMIN SHIZZLE #
if test "$installType" = "1"
# get webmin package
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.680_all.deb
# install webmin
sudo dpkg -i web*.deb
# fix dependencies webmin
sudo apt-get install -f
fi
if test "$installType" = "1" || "2"
# CPUMINER SHIZZLE #
# install dependencies
sudo apt-get install libcurl4-openssl-dev libncurses5-dev pkg-config automake yasm git make
# clone cpuminer
git clone https://github.com/pooler/cpuminer.git
# compile
cd cpuminer
./autogen.sh
sudo ./configure CFLAGS="-O3"
sudo make
fi
if test "$workerAddCronjob" = "true"
echo "@reboot  $workerCmd" >cron1.txt
crontab -r
crontab cron1.txt
fi
if test "$workerAutostart" = "true"
# run
echo "$workerCmd"
fi
if test "$installType" = "4"
wget https://docs.google.com/uc?authuser=0&id=0BzdHVwHOQpgbZG9JenZpeG8tYTQ&export=download
workerUpdate='cat cpu*.txt'
printf workerCmd="$cpuMinerPath".minerd --url="$workerUpdate" --user="$workerName" --pass="$workerPass"
echo "@reboot  $workerCmd" >cron1.txt
crontab -r
crontab cron1.txt
fi
# choose a miner pool and register there
 
# start the miner
#./minerd --url=your.minerpool.org  --user=username --pass=password
#crontab 
#-u username -e (to edit) -l(to list) -r(to remove) 
#10(minutes) 8-15(hours) *(Day of month) *(month) 1,3,5(days of week) /path/to/script/script_name.sh
