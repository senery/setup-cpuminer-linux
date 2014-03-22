sudo -s

sudo yum update
# create and go to working dir
sudo mkdir /home/mine
cd /home/mine

# WEBMIN SHIZZLE #
# get webmin package
wget http://prdownloads.sourceforge.net/webadmin/webmin-1.680-1.noarch.rpm

# install webmin
sudo rpm -U webmin-1.680-1.noarch.rpm

# CPUMINER SHIZZLE #
# install dependencies
sudo yum install gcc make curl-devel wget

# get cpuminer
wget http://sourceforge.net/projects/cpuminer/files/pooler-cpuminer-2.3.2.tar.gz
tar xzf pooler-cpuminer-2.3.2.tar.gz
cd cpuminer-2.3.2/

# compile
./configure CFLAGS="-O3"
sudo make

# run
/home/mine/cpu*/minerd --url=stratum+tcp://ltc.ghash.io:3333 --user=ReemZzz.ltc --pass=123