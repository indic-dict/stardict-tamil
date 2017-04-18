clear;
read -p "
Please enter address of dictionary's homepage. (for example like http://dsal.uchicago.edu/dictionaries/brown/ for brown telugu dictionary.) : " dHomePage
dDictName=$(echo "${dHomePage}" | sed -n 's/^.*dictionaries\/ *\([^\/][^\/]*[^\/ ]\) *\/.*$/\1/p;' )
echo "
Dictionary name: ${dDictName}
----------------------------------"
read -p "
1) Scraping -dictionary pages- :
please enter upper limit of page number for this dictionary..
How to check upper limit -: the page urls for this dict are in form of http://dsalsrv02.uchicago.edu/cgi-bin/app/${dDictName}_query.py?page=172  , is for page number 172 for example. so give differant page numbers for dictionary page number, and the page number after which all next pages are blank templates with out results is the upperlimit page number. another caution is, some times though some next pages are blank after a page number, there exists pages with results after some blank template pages,and thus that page number is not upperlimit,and upperlimit is much higher. So be sure that after that upperlimit page number,no content pages exist. for example , for above brown_telugu_dictionary upperlimit page number is 1409. for this brown dict, i first checked page number 1000, and it exists. then checked 1500, it doesn't exists. like this trial and shrinking interval, we can find upperlimit with in some 6 tests . So after checking please enter Upperlimit page number for dict $dDictName : " dUpperLimit

echo "
upper limit page number : ${dUpperLimit}
and hence last dictionary page URL : http://dsalsrv02.uchicago.edu/cgi-bin/app/${dDictName}_query.py?page=${dUpperLimit}
"
read "
Enter language code of language in which headwords of this this dict are in . like te for telugu, sa for devanagari kn for kannada, etc. : " dLangCode
rm DictPage_URLS.txt
for((i=1;i<=${dUpperLimit};i++));do echo "http://dsalsrv02.uchicago.edu/cgi-bin/app/${dDictName}_query.py?page=${i} " >> DictPage_URLS.txt; done
sed -i 's/^ *//; s/ *$//;' DictPage_URLS.txt
#for((i=1;i<=${dUpperLimit};i++));do echo "http://127.0.0.1/pages/brown_query_$i.htm" >> DictPage_URLS.txt; done
mkdir DictPages
parallel -j10 wget -nv --directory-prefix=DictPages :::: DictPage_URLS.txt
cd DictPages && fnum=1
for file in *; do mv $file dPage_${fnum}.htm; fnum=$((fnum+1)); done

for file in *.htm; do  sed 's/< *\/a *>/✔/g;' $file | sed '/query.py?qs=/! d' | sed 's/^[^✔]*<a  *href=" *\([^"<>]*[^"<> ]\) *" *>.*$/\1/;' >> ../dPada_urls.txt; done

cd - && mkdir PadaPages
parallel -j10 wget -nv --directory-prefix=PadaPages :::: dPada_urls.txt
cd PadaPages && dPS1=0
for file in *; do dPS1=$((dPS1+1));mv $file dPada_${dPS1}.htm;  done
dDictionaryName=$(sed -n 's/^.*<title> *\([^<>]*[^<> ]\) *<\/title>.*$/\1/p;' dPada_1.htm)
rm ../dAW1.txt
for file in *.htm; do sed '/<hw>/!d;' $file | sed 's/^.*<hw>/<hw>/;' >> ../dAW1.txt; done
cd -
sed 's/ *( *<a href="[^"<>]*"> *p *\. *[0-9][0-9]* *<\/a> *)//;' dAW1.txt |sort -u > dAW2.txt

sed 's/<\/hw>/✔/; s/^<hw> *\([^✔]*[^✔ ]\) *✔/\n\1\n<B>&<\/B>/;' dAW2.txt|sed '1d'|sed '$s/$/\n/;' | sed '1~3s/<[^<>]*>//g; s/^ *//; s/ *$//; s/✔/<\/hw>/;' | sed "1s/^/\n#stripmethod=keep\n#sametypesequence=h\n#bookname=${dDictName} ${dDictionaryName}\n\n/;" >${dDictName}_mula.babylon
 
clear;
echo "
Done. ${dDictName}_mula.babylon is the mula babylon file. which can be compiled and used. But according to language, structure we can improve that babylon with transliteration,which can be eaasily added and hyperlinking too can be added.

And to note, all scraped word pages are in ./PadaPages folder, and all original URls of those words to dsal server are listed in dPada_urls.txt

all scraped 'Dictionary pages' are in ./DictPages folder, and all original URls of those 'Dictionary Pages' to  dsal server are listed in DictPage_URLS.txt
"


