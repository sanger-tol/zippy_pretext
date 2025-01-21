
hicmap=$1
agpfile=$2
idxfile=$3
juicer pre -q 0 ${hicmap} ${agpfile} ${idxfile} 2>juicercout.log | LC_ALL=C sort -k2,2d -k6,6d -T . --parallel=8 -S50G | awk '$3>=0 && $7>=0' 