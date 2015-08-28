# time-machinery-sh
<b>rsnapshot.sh</b> is a very simple shell script to do backups similarly to "Back In Time" or Apple's "Time Machine"; <b>teletime.sh</b> is a complementary simple script to run programs "in the past" meaning setting environmental variables so that programs see your backed up HOME folder instead of your actual one.

<h1>rsnapshot.sh</h1>
<b>rsnapshot.sh</b> backups to your location of choice. It uses rsync and cp.<br>
Go ahead and install rsync. Edit parameters in rsnapshot.sh, apply "chmod +x rsnapshot.sh" and run the script. Now you have nice little backup system.<br>
<br>
Running it each 10 minutes will produce subfolders inside your backup folder, example:
<pre>
2015-08-28-18:25
2015-08-28-18:36
2015-08-28-18:47
2015-08-28-18:57
2015-08-28-19:08
latest
</pre>
Here each subfolder corresponds to a snapshot of your HOME<br><br>
<h2>Running it periodically</h2>
To run backups periodically you could use 1) systemd (if you have it) 2) cron, or 3) plain bash.<br>
<br>
<h3>1) systemd (if you have OS X skip it and go to 2-3)</h3>
With systemd, edit rsnapshot-sh.timer and rsnapshot-sh.service and put them to a folder for User level of systemd. I use 
/home/YOURUSER/.config/systemd/user/<br>
Then you enable and run timer unit with:<br>
<pre>
systemctl --user enable rsnapshot-sh.timer
systemctl --user start rsnapshot-sh.timer
</pre>
<h3>2) cron</h3>
Install cron and add crontab
<pre>crontab -e</pre>
<h3>3) Plain bash</h3>
This could be usefull if you plan to run periodical backups only occasinally e.g. when you code and want to track versions without using versioning systems or if you cannot install cron.<br>
<h4>using watch</h4>
To run it each 10 minutes (60*10=600 seconds) do
<pre>
watch -n 600 ./rsnapshot.sh
</pre>
or 
<h4>using loop and sleep</h4>
<pre>
while true; do ./rsnapshot.sh; sleep 600; done
</pre>
<h1>teletime.sh</h1>
To run programs in modified environment so backed up HOME folder appears as actual one to them.<br>
Tricking python:
<pre>
bash teletime.sh 2015-08-28-00:59 python
</pre>
Tricking bash:
<pre>
bash teletime.sh 2015-08-28-00:59 bash
</pre>
<h1>References</h1>
<a href="https://wiki.archlinux.org/index.php/Rsync">https://wiki.archlinux.org/index.php/Rsync</a><br>
<a href="https://wiki.archlinux.org/index.php/Cron">https://wiki.archlinux.org/index.php/Cron</a><br>
<a href="https://wiki.archlinux.org/index.php/Systemd/Timers">https://wiki.archlinux.org/index.php/Systemd/Timers</a><br>
<a href="https://wiki.archlinux.org/index.php/Systemd/User">https://wiki.archlinux.org/index.php/Systemd/User</a><br>
<a href="http://learnxinyminutes.com/docs/bash/">http://learnxinyminutes.com/docs/bash/</a><br>
