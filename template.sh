#!/bin/bash -i

TODAY=$(date +%j)
TODAY_nozero=${TODAY##+(0)}
dateToday=$(date +"%Y_%m_%d")
HALLOWEEN=$(date -d "Oct 31" +%j)
NEXTHALLOWEEN=$(($(date -d "Oct 31 +1 years" +%j)+366))
DAYS_ThisHalloween=$(($HALLOWEEN - $TODAY_nozero))
DAYS_NextHalloween=$(($NEXTHALLOWEEN - $TODAY_nozero))

if [ "$DAYS_ThisHalloween" == 0 ]
then
Halloween_Status=$(echo "🎃Happy Halloween🎃")
elif [ "$DAYS_ThisHalloween" == 182 ]
then
Halloween_Status=$(echo "${DAYS_ThisHalloween} - Happy Halfway-ween!")	
elif [ "$HALLOWEEN" -gt "$TODAY_nozero" ]
then
Halloween_Status=$(echo "$DAYS_ThisHalloween")
elif [ "$HALLOWEEN" -lt "$TODAY_nozero" ]
then
Halloween_Status=$( echo "$DAYS_NextHalloween" )
else Halloween_Status=$( echo "🎃" )
fi

if [ ! -f ${dateToday}.txt ] ; then
previous_day=$(ls -Art | ls *.txt | tail -n 1) ;
previous_plans=$(awk '/Plans:/{flag=1;next}/Notes:/{flag=0}flag' $previous_day | sed '/FINISHED/d' | sed '/^- yesterday/d' |  sed '/^- tomorrow/d' |  sed '/^- today/d' | awk '/---------------------------------------------------------------------------------/{flag=1;next}/---------------------------------------------------------------------------------/{flag=0}flag');
for_tomorrow=$(awk '/For Tomorrow:/{flag=1;next}/############/{flag=0}flag' $previous_day);
echo "#################################################################################

Date: $dateToday ################################################################

$(cal | sed 's/\ /-/g' | sed 's/-1-/01/' | sed 's/-2-/-02/' | sed 's/-3-/-03/' | sed 's/-4-/-04/' | sed 's/-5-/-05/' | sed 's/-6-/-06/' | sed 's/-7-/-07/' | sed 's/-8-/-08/' | sed 's/-9-/-09-/' | sed 's/^-//g' | sed -r "s/\b$(date|cut -d ' ' -f2)\b/XX/" | sed 's/-/\ /g')

Days Until Halloween: $Halloween_Status

To-do for today:#################################################################

Plans: ##########################################################################

$for_tomorrow
---------------------------------------------------------------------------------
$previous_plans

Notes: ##########################################################################

What I've Learned / Conclusion: #################################################

For Tomorrow: ###################################################################

Weather: ########################################################################

$(ansiweather -l lexington -a false)

$(finger lexington@graph.no)

Moon Info: #######################################################################

- $(curl -s https://www.moongiant.com/phase/today | grep '<div id="moonDetails" class=""> Phase' | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/<divid="moonDetails"class="">//g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')
- $(curl -s https://www.moongiant.com/phase/today | grep "Illumination" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\///g' | sed 's/<\|>//g' | tail -n 1 )
- $(curl -s https://www.moongiant.com/phase/today | grep "Moon Age" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')
- $(curl -s https://www.moongiant.com/phase/today | grep "Moon Angle" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')º
- $(curl -s https://www.moongiant.com/phase/today | grep "Moon Distance" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')
- $(curl -s https://www.moongiant.com/phase/today | grep "Sun Angle" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')º
- $(curl -s https://www.moongiant.com/phase/today | grep "Sun Distance" | sed 's/\<span\>//g' | sed 's/ //g' | sed 's/\<\/span\>//g' | sed 's/\<br\>//g' | sed 's/\///g')

\/\/\/\/\/\/\/\  ssh lcc cat - scripts run on ${dateToday}  /\/\/\/\/\/\/\/\/\/\/
" >> ${dateToday}.txt;
sed -i 's|[<>,]||g' ${dateToday}.txt;
sed -i -e '/./b' -e :n -e 'N;s/\n$//;tn' ${dateToday}.txt;
sed -i '/^alias\ today=/d' ~/.bashrc;
echo "alias today='vim /mnt/c/Users/jamie/Documents/PhD/LabNotebook/${dateToday}.txt'" >> ~/.bashrc;
source ~/.bashrc;
vim ${dateToday}.txt
else
	cowsay -f jack "$Halloween_Status Days Until Halloween"
fi

