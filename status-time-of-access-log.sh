#!/bin/sh 
# 统计nginx access log中请求耗时比例
# 
cd /data/logs/nginx/
for $FOLDER in `ls|grep 2014_1` 
 do 
	printf "$FOLDER\t"
    awk '
	BEGIN{sum=0}
	{
		if($NF<=0.15)
			++S["<=150ms"];
		else if($NF<=0.3)
			++S["<=300ms"];
		else if($NF<=0.5)
			++S["<=500ms"];
		else if($NF<=0.8)
			++S["<=800ms"]
		else if($NF<=1)
			++S["<=1 sec"];
		else if($NF<=2)
			++S["<=2 sec"];
		else
			++S["> 2 sec"];
		++sum
	} 
	END {
		printf("request Sum was:%d\n",sum);
		for(a in S) 
			printf("%s \t %d \t %0.6f%%\n", a, S[a], S[a]/sum * 100);
	}' $FOLDER/access.log 
	printf "\n---------\n"
done