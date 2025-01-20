header=$1
alignment=$2

version='1.0.0'
if [ $1 == '-v'];
then
    echo "$version"
else
    (cat $header; cat $alignment|awk '{print ".\t"$2"\t"$3"\t"$6"\t"$7"\t.\t."}') | gzip
fi
