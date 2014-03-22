# update repos
sudo apt-get update

# create and go to working dir
mkdir /home/mine
cd /home/mine

# WEBMIN SHIZZLE #
# get webmin package
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.680_all.deb

# install webmin
sudo dpkg -i web*.deb

# fix dependencies webmin
sudo apt-get install -f

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