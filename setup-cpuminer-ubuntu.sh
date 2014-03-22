###########################################################
# Install type
# 1 : full (webmin + cpuminer + dependencies)
# 2 : no webmin install (only cpuminer + dependencies)
# 3 : install dependencies
# #########################################################
installType=1
###########################################################
# Create Cronjob for minerd
###########################################################
workerAddCronjob=1
###########################################################
# Worker setup
###########################################################
workerLogin=senery
workerStandalone=1
workerAutostart=1
workerPass=123
workerUrl="stratum+tcp://stratum.scryptguild.com:3333"
workerTime=$(date +"%d%m%H%S")


printf workerName=senery."$HOSTNAME"
# update repos
sudo apt-get update

# create and go to working dir
mkdir /home/mine
cd /home/mine

# WEBMIN SHIZZLE #
if test "$installType" = "1"
# get webmin package
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.680_all.deb
# install webmin
sudo dpkg -i web*.deb
# fix dependencies webmin
sudo apt-get install -f
fi

if test "$installType" = "1"
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

# run
cd /home/mine/cpu*
./minerd --url=stratum+ttcp://ltc.ghash.io:3333  --user=senery.cloudvps --pass=123
 
# choose a miner pool and register there
 
# start the miner
#./minerd --url=your.minerpool.org  --user=username --pass=password
#crontab 
#-u username -e (to edit) -l(to list) -r(to remove) 
#10(minutes) 8-15(hours) *(Day of month) *(month) 1,3,5(days of week) /path/to/script/script_name.sh
