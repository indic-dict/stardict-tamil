mkdir మూల_html pages
for((i=1;i<=4351;i++));do  wget --output-document=pages/lexpg_$i.htm  http://www.tamilvu.org/slet/servlet/lexpg?pageno=$i; echo $i; done
cp pages/*.htm మూల_html/
sed -i.bk 's/\r//g;' మూల_html/*.htm
sed -i.bk '1,/<\/h3><\/th><\/tr>/d;' మూల_html/*.htm
sed -i.bk '/^ *$/d;'  మూల_html/*.htm
sed -i.bk '$s/^ *<tr bgcolor=ivory align=center [^<>]*> *$/#########@#/;'  మూల_html/*.htm
sed -i.bk '/#########@#/d;'  మూల_html/*.htm
sed -i.bk '/^<\/table><\/center>/,$d;'  మూల_html/*.htm
for((i=1;i<=4351;i++));do sed 's/\t//g;' మూల_html/lexpg_$i.htm|tr '\n' '\t' |sed 's/\t* *<tr/\n<tr/g; s/\t//g;' >> మూల1.html; done
sed -i.bk '/^ *$/d;' మూల1.html
sed -i.bk 's/<\/td>$/<\/td><\/tr>/;' మూల1.html
sed 's/<\/font>/✔/g;s/^<tr[^<>]*> *<td width=100 align=left valign=top><font color=blue>\([^✔]*\)✔.*$/\1/g;' మూల1.html > తమిళ1.శి
sed  -i 's/^ *//; s/ *$//; s/ *- */-/g; s/ *<sup> *\([0-9][0-9]*\) *<\/sup>/_\1/;' తమిళ1.శి
sed -i 's/ *[,\.;:] *$//;' తమిళ1.శి
sed  's/^\(.*\)\(_[0-9][0-9]*\)\(.*$\)/&|\1\3/g; s/^\(.*\)-\(.*$\)/&|\1\2|\1/g;' తమిళ1.శి > తమిళ_ప్ర1
sed '/<td align=left valign=top><font color=blue>/!s/^.*$//; s/<\/font>/✔/g; s/^.*<td align=left valign=top><font color=blue>\([^✔]*\)✔.*$/\1/g;' మూల1.html > ఉచ్ఛారణ1.శి
sed -i "s/$(echo -ne '\u009D')//g" ఉచ్ఛారణ1.శి
sed  -i 's/^ *//; s/ *$//; s/ *- */-/g; s/ *[,\.;:] *$//;' ఉచ్ఛారణ1.శి
sed -i 's/ *, *[0-9]* *$//g;'  ఉచ్ఛారణ1.శి
sed 's/-//g;'  ఉచ్ఛారణ1.శి > తత్కాల్1 && paste ఉచ్ఛారణ1.శి  తత్కాల్1 |sed 's/\t/|/g; s/^|//; s/|$//; s/||*/|/g;s/^\([^|]*\)|\1$/\1/;' >ఉచ్ఛారణ2.శి
 sed 's/<\/font>/✔/g; s/<tr[^<>]*><td width=100 align=left valign=top><font color=blue>\([^✔]*\)✔ *<\/td>/<span class="shirshika">\1<\/span><hr>/g; s/<td align=left valign=top><font color=blue>\([^✔]*\)✔/<span class="uchcharana">\1<\/span>/;s/<font color=red>\([^✔]*[^✔<>\/]\)\(<<[\/<>]*\)\([^✔]*\)✔/<font color=red>\1\&lt;\3✔/g;  s/<font color=red>\([^✔]*\)✔/<span class="vyutpatti">\1<\/span>/; s/<\/td>\|<\/tr>//g;' మూల1.html >మూల2.html
sed 's/_[0-9][0-9]*//;' తమిళ1.శి >tatkal1
sed -i 's/\(^.*\)-\(.*$\)/&\n\1\2\n\1/;' tatkal1
while read -r line; do echo ${#line}; done < tatkal1 > pl.txt && paste pl.txt tatkal1 > tatkal1.1
cp మూల2.html మూల3.html
sort -nr tatkal1.1|sed 's/^[0-9]*\t//;' |sed 's/\(^.*$\)/\\(\[ ,\\.(){}\\":;<>=\\\&?_-\]\\)\1\\(\[ ,\\.(){}\\":;<>=\\\&?_-\]\\)/;'|tr '\n' '\t' > తత్కాల్2
for((i=1;i<=150;i++));do sed -i "${i}s/\t/\n/1000;" తత్కాల్2; done
sed -i 's/\t/|/g; s/^/sed -i s\//g; s/$/\/✔\&♛\/g; మూల3\.html/;' తత్కాల్2
sed -i "s/;\( మూల3.html$\)/;'\1/; s/sed -i /sed -i '/;"  తత్కాల్2
sed -i 's/|/\\|/g;' తత్కాల్2
sed -i 's/\\|\//\//;' తత్కాల్2
bash  తత్కాల్2
sed 's/✔\([^✔♛]*\)✔/✔\1/g; s/♛\([^✔♛]*\)♛/\1♛/g; s/✔\([^✔♛]*\)✔/✔\1/g; s/♛\([^✔♛]*\)♛/\1♛/g; s/"shirshika"✔>\([^♛]*\)♛/"shirshika">\1/;' మూల3.html > మూల4.html
sed -i 's/✔\(.\)\([^♛]*\)\(.\)♛/\1<a class="tl_pada" href="\2">\2<\/a>\3/g;'  మూల4.html
paste  తమిళ_ప్ర1 ఉచ్ఛారణ2.శి |sed 's/\t/|/;' > శీర్షికలు
sed 's/$/\n\n/;' శీర్షికలు > తత్కాల్3 && sed 's/$/\n\n/g; 1s/^/\n/;' మూల4.html|sed '$d' > తత్కాల్4
paste తత్కాల్3 తత్కాల్4 |sed 's/^\t//; s/\t$//;' > తమిళ_శబ్దకోశం_0.babylon
sed -i.bk '1s/^/\n#stripmethod=keep\n#sametypesequence=h\n#bookname=Tamil_Lexicon\n#వందనాలు : అమ్మకి\n\n/;' తమిళ_శబ్దకోశం_0.babylon
sed -i '8~3s/^\(.*\)$/<div class="tl_patra">\1<\/div>/;' తమిళ_శబ్దకోశం_0.babylon
sed -i '/<p>/s/<\/div>$/<\/p><\/div>/;' తమిళ_శబ్దకోశం_0.babylon
sed  '8~3s/<\/span>/☆/g; 8~3s/<span class="shirshika">\([^☆]*\)☆/<B>\1<\/B>/; s/<span class="vyutpatti">\([^☆]*\)☆/<font color="red">\1<\/font>/; s/<span class="uchcharana">\([^☆]*\)☆/<font color="blue">\1<\/font>/; s/<div class="tl_patra">/<div style="max-width:55.8em;margin: 0 auto 0 auto;">/;'  తమిళ_శబ్దకోశం_0.babylon > తమిళ_శబ్దకోశం.babylon
sed -i '7~3s/|[ |]*/|/g; 7~3s/^|//; 7~3s/|[ \t]*$//;' తమిళ_శబ్దకోశం.babylon
sed -i.bk 's/<a class="tl_pada"\([^<>]*\)>\([^<>]*\)<\/a>/<a style="text-decoration:none;color:#2f4f4f;"\1>\2<\/a>/g;' తమిళ_శబ్దకోశం.babylon
sed -i '8~3s/^/<style>a.tl_X{text-decoration:none;color:#2f4f4f;}<\/style>/; s/<a style="text-decoration:none;color:#2f4f4f;"/<a class="tl_X"/g;' తమిళ_శబ్దకోశం.babylon
mv తమిళ_శబ్దకోశం.babylon tamil_lexicon.babylon
rm తమిళ_శబ్దకోశం.babylon తమిళ_శబ్దకోశం_0.babylon శీర్షికలు తత్కాల్2 తత్కాల్* మూల[1234].html తమిళ1.శి  tatkal1 
sed 's/<style>.*<\/style>//; s/<\/font>/☀/g; s/<font color="red">\([^☀]*\)☀/\1<BR>=========================/; s/☀/<\/font>/g; s/<font[^<>]*>//g; s/<\/font>//g; s/<div[^<>]*>//g; s/<\/div>//g; s/<a class="[^"<>]*"/<a /g;' tamil_lexicon.babylon > tamil_lexicon_minimal.babylon
sed -i 's/^.*<hr>//;' tamil_lexicon_minimal.babylon


