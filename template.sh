#!/bin/bash -i

TODAY=$(date +%j)
dateToday=$(date +"%Y_%m_%d")
HALLOWEEN=$(date -d "Oct 31" +%j)
NEXTHALLOWEEN=$(($(date -d "Oct 31 +1 years" +%j)+367))
DAYS_ThisHalloween=$(($HALLOWEEN - $TODAY))
DAYS_NextHalloween=$(($NEXTHALLOWEEN - $TODAY))

if [ "$DAYS_ThisHalloween" == 0 ]; then
Halloween_Status=$(echo "🎃Happy Halloween🎃" );
elif [ "$HALLOWEEN" -gt "$TODAY" ]; then
Halloween_Status=$(echo "$DAYS_ThisHalloween" );
elif [ "$HALLOWEEN" -lt "$TODAY" ]; then
Halloween_Status=$( echo "$DAYS_NextHalloween" );
fi 

if [ ! -f ${dateToday}.txt ] ; then
previous_day=$(ls -Art | ls *.txt | tail -n 1) ; 
previous_plans=$(awk '/Plans:/{flag=1;next}/Notes:/{flag=0}flag' $previous_day | sed '/^x/d' | sed '/^- yesterday/d' |  sed '/^- tomorrow/d' |  sed '/^- today/d'); 
for_tomorrow=$(awk '/For Tomorrow:/{flag=1;next}/############/{flag=0}flag' $previous_day); 
echo "
#################################################################################

Date: $dateToday ################################################################
$(gcal | sed "s/$(date +"%d")/ XX /")

Days Until Halloween: $Halloween_Status 

To-do for today:################################################################# 

Plans: ##########################################################################

$for_tomorrow

$previous_plans

Notes: ##########################################################################

What I've Learned / Conclusion: #################################################

Weather: ########################################################################

$(ansiweather -l lexington -a false)

$(finger lexington@graph.no)

Moon Info: #######################################################################

- $(curl -s https://www.moongiant.com/phase/today | grep '                                <div id="moonDetails" class=""> Phase' | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/<divid="moonDetails"class="">//g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')
- $(curl -s https://www.moongiant.com/phase/today | grep "                                    Illumination" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\///g')
- $(curl -s https://www.moongiant.com/phase/today | grep "                                    Moon Age" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')
- $(curl -s https://www.moongiant.com/phase/today | grep "                                    Moon Angle" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')º
- $(curl -s https://www.moongiant.com/phase/today | grep "                                    Moon Distance" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g') 
- $(curl -s https://www.moongiant.com/phase/today | grep "                                    Sun Angle" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')º
- $(curl -s https://www.moongiant.com/phase/today | grep "                                    Sun Distance" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')

#################################################################################
\/\/\/\/\/\/\/\  ssh lcc cat - scripts run on ${dateToday}  /\/\/\/\/\/\/\/\/\/\/
" >> ${dateToday}.txt; 
sed -i 's|[<>,]||g' ${dateToday}.txt;
sed -i -e '/./b' -e :n -e 'N;s/\n$//;tn' ${dateToday}.txt;
sed -i '/^alias\ today=/d' ~/.bashrc; 
echo "alias today='vi ${dateToday}.txt'" >> ~/.bashrc;
source ~/.bashrc;
vi ${dateToday}.txt
else
echo "$Halloween_Status Days Until Halloween"
fi


