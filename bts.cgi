#!/bin/bash
echo -ne "Content-type: text/html; charset=UTF-8\n\n"

cat << EOF
<html>
<head>
<title>Debian Bug Tracking System News</title>
<meta http-equiv="Refresh" content="3900; URL=http://localhost/bts/">
<style type="text/css"><!--
@import url('https://rsms.me/inter/inter.css');
html { font-family: 'Inter', sans-serif; }
@supports (font-variation-settings: normal) {
  html { font-family: 'Inter var', sans-serif; }
}
    th,td,body {
	font-size: medium;
	font-family: sans-serif;
    }
--></style>
EOF
CSS=bts.css
q=`echo $QUERY_STRING | sed "s,?,,g"`
if [ -z $QUERY_STRING ]; then echo -n; else CSS=http://${q}; fi
echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"$CSS\">"
cat << EOF
</head>
<body>
<h1>Debian Bug Tracking System News</h1>
<a href="https://www.debian.org/"><img src=debian.png alt="Debian" border=0 height="16"></a> 
<a href="rss.cgi"><img src=rss_2_0.png alt="RSS Feed" border=0 height="16"></a> | different CSS <a href=?www.icebrrg.com/Styles/Master/c/style.css>www.icebrrg.com</a> | <a href=?www.debian.org/debhome.css>www.debian.org</a><br>
These are the bugs touched during the last four hours. The data will be updated in <b>`echo 60-$(date +%M) | bc`</b> minutes.<br>
<a href="http://bugs.debian.org/release-critical/">RC Bug Graph</a> | <a href="http://www.debian.org/Bugs/pseudo-packages">Pseudo Packages</a> | <a href="http://www.debian.org/Bugs/Developer#severities">Severities</a> | <a href="http://buildd.debian.org/quinn-diff/Packages-arch-specific">P-A-S</a> | <a href="http://packages.debian.org/unstable/main/newpkg">New Packages in "sid"</a> |
<a href="https://release.debian.org/transitions/index.html">Transitions</a> |
<a href="https://db.debian.org/machines.cgi">Developer Machines</a> |
<a href="https://release.debian.org/">Releases</a>
EOF

#cd /var/www/bts/

echo "<p>"
echo "Active Bugs"
printf "<b>%0.0f</b>\n" $(tail -1 /var/www/bts/.num-db)
echo \(`(tail -2 .num-db | head -1;tail -1 .num-db) | (read a;read b;printf "%+0.0f\n" $(echo $b-$a|bc))`\)
printf "%0.0f mb\n" `tail -1 .size-db`
echo "<br>Archived Bugs"
printf "<b>%0.0f</b>\n" `tail -1 .num-arch`
echo \(`(tail -2 .num-arch | head -1;tail -1 .num-arch) | (read a;read b;printf "%+0.0f\n" $(echo $b-$a|bc))`\)
printf "%0.0f mb\n" `tail -1 .size-arch`
echo "<br>Debian <a href=https://ftp-master.debian.org/deferred.html>DEFERRED</a>"
echo "<br>Debian <a href=http://ftp-master.debian.org/new.html>NEW</a> closable bugs"
printf "<b>%0.0f</b> (<a href=http://molly.corsac.net/~corsac/debian/new/>%0.0f/%0.0f</a>)\n" `tail -1 .ftp-closes` `tail -1 .new-total | awk '{print $1}'` `tail -1 .new-total | awk '{print $2}'`
echo "<br>Source packages in <a href=http://incoming.debian.org>incoming.debian.org</a>"
printf "<b>%0.0f</b>\n" `tail -1 .incoming`
echo "<br>Package movement for <a href=http://bjorn.haxx.se/debian/accepted.html>testing</a>"
printf "<b>%s</b>\n" `tail -1 .testing-moves`
echo "<br><a href=http://www.debian.org/devel/wnpp/orphaned>Orphaned packages</a>"
printf "<b>%0.0f</b>\n" `tail -1 .orphaned`
echo "<br>Popularity contest"
printf "<a href=http://popcon.debian.org/>Debian</a> <b>%0.0f</b>\n" `tail -1 .popcon-debian`
echo \(`(tail -2 .popcon-debian | head -1;tail -1 .popcon-debian) | (read a;read b;printf "%+0.0f\n" $(echo $b-$a|bc))`\)
printf "<a href=http://popcon.ubuntu.com/>Ubuntu</a> <b>%0.0f</b>\n" `tail -1 .popcon-ubuntu`
echo \(`(tail -2 .popcon-ubuntu | head -1;tail -1 .popcon-ubuntu) | (read a;read b;printf "%+0.0f\n" $(echo $b-$a|bc))`\)
printf "<a href=http://popcon.devuan.org/>Devuan</a>\n"
#echo \(`(tail -2 .popcon-devuan | head -1;tail -1 .popcon-devuan) | (read a;read b;printf "%+0.0f\n" $(echo $b-$a|bc))`\)
printf "<br>Total registered dpkg/apt Users <b>%0.0f</b>\n" $(echo `tail -1 .popcon-ubuntu` + `tail -1 .popcon-debian` | bc)
now=`date +%s`
rel=`date -d "14 August 2027" +%s`
echo "<br>Days until Forky release (14 August 2027) <a href=http://wiki.debian.org/DebianForky>" `echo "($rel-$now)/60/60/24"|bc` "</a>"
now=`date +%s`
rel=`date -d "14 August 2029" +%s`
echo "<br>Days until Duke release (14 August 2029) <a href=http://wiki.debian.org/DebianDuke>" `echo "($rel-$now)/60/60/24"|bc` "</a>"
now=`date +%s`
rel=`date -d "23 April 2026" +%s`
echo "<br>Days until next Ubuntu LTS release (23 April 2026) <a href=https://discourse.ubuntu.com/t/resolute-raccoon-release-schedule/47198>" `echo "1+($rel-$now)/60/60/24"|bc` "</a>"
now=`date +%s`
rel=`date -d "23 April 2028" +%s`
echo "<br>Days until next Ubuntu LTS release (23 April 2028) <a href=https://discourse.ubuntu.com/t/resolute-raccoon-release-schedule/47198>" `echo "1+($rel-$now)/60/60/24"|bc` "</a>"
#echo "<br>wnpp-rfp -> wnpp-itp -> (experimental | sid) -> testing -> stable -> old-stable -> orphaned"
echo "</p>"

echo "<br>"
echo "<table>"
echo "<tr>"
echo "<th align=left title=\"bug number\">Bug</th><th align=left title=\"bug severity\">Severity</th><th align=left title=\"number of people involved\">People</a><th align=left title=\"package name\">Package</th><th align=left title=\"bug subject\">Subject</th>"
echo "</tr>"
find bts-spool-db -name "*.summary" -type f -mmin -240 | while read b; do
    bug=`echo $b | sed "s,.*/,,;s,.summary,,"`
    p=`cat $b | grep ^Package: | sed "s,^Package: ,,"`
    s=`cat $b | grep ^Subject: | sed "s,^Subject: ,,"`
    se=`cat $b | grep ^Severity: | sed "s,^Severity: ,,"`
    npf=`echo $b | sed "s,.summary,,g"`
    np=`cat ${npf}.log | grep ^From: | sort -u | wc -l | awk '{print $0-1}'`

    case x${se} in
	*critical)
	    se2="<blink>${se}</blink>"
	    se=${se2}
	;;
	*grave)
	    se2="<blink>${se}</blink>"
	    se=${se2}
	;;
	*serious)
	    se2="<blink>${se}</blink>"
	    se=${se2}
	;;
    esac

    echo "<tr>"
    echo "<td valign=top><a href=http://bugs.debian.org/${bug}>${bug}</a></td>"
    echo "<td valign=top>${se}</td>"
    echo "<td valign=top><a href=http://asdfasdf.debian.net/~tar/pkgstats/?${p}>${np}</a></td>"
    echo "<td valign=top>"
    for ip in `echo $p | sed "s/,/\ /g"`; do
	case $ip in 
	    ftp.debian.org)
		echo "${ip}<br>"
	    ;;
	    qa.debian.org)
		echo "${ip}<br>"
	    ;;
	    wnpp)
		echo "${ip}<br>"
	    ;;
	    *)
		echo "<a href=http://packages.debian.org/${ip}>${ip}</a><br>"
	    ;;
	esac
    done
    echo "</td>"
    echo "<td valign=top>${s}</td>"
    echo "</tr>"
done
# | sort -nr
echo "</table>"

echo "<p>"
echo "Last update: `cat timestamp` (updated once every full hour by <a href=\"index.txt\">index.cgi</a>), thanks to <a href=mailto:sonicmctails@gmail.com>Michael Casadevall</a> for the RSS part.<br>"
