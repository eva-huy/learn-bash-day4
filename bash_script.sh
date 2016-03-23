max=5
for (( i=1; i <= $max; ++i ))
do

		curl -o result.day$i.log.gz  http://aucfantrain.vn/day04/result.day0$i.log.gz
		zcat < result.day$i.log.gz >> log_main.log

done

echo "------------------------------------------------"
echo "1.The number of unique user for each days"
echo "------------------------------------------------"
for (( i=1; i <= $max; ++i ))
do
	DAY=$(zcat < result.day$i.log.gz | cut -f 3 | sort | uniq | wc -l)
	echo "Day $i: " $DAY " users"
done

echo $(cut -f 2- log_main.log | sort | uniq) > log_main_uniq.log
echo "------------------------------------------------"
echo "2.The number of unique user for each regions"
echo "------------------------------------------------"
COUNTRY=$(cut -f 2 log_main.log | sort | uniq)
for c in $COUNTRY; 
do 
	
	NUM=$(grep -o $c log_main_uniq.log | wc -l)
	echo $c " : " $NUM " users"; 
done

echo "------------------------------------------------"
echo "2.The number of unique user in total"
echo "------------------------------------------------"
TOTAL=$(cut -f 3 log_main.log | sort | uniq | wc -l)
echo "Total : " $TOTAL " users"
