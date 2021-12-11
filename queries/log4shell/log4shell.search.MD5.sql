/*

Log4Shell (CVE-2021-44228) helper

This SQL query will search for log4j*.jar files on your system, vulnerable to CVE-2021-44228 (nicknamed 
Log4Shell), by using Microsoft Logparser 2.2. It will calculated MD5 hashes of every log4*j.jar file that 
will be found in the selected folders and compare their hash with a list of MD5 hashes. The list of known 
MD5 haseshes is taken from here: https://github.com/mubix/CVE-2021-44228-Log4Shell-Hashes/blob/main/md5sum.txt 

More about log4shell resources:
	https://www.lunasec.io/docs/blog/log4j-zero-day/
	https://mbechler.github.io/2021/12/10/PSA_Log4Shell_JNDI_Injection/
	

What you need to run this script:

	- Microsoft Logparses 2.2. Download from here: https://www.microsoft.com/en-us/download/details.aspx?id=24659

	- Optimally Log Parser Lizard - GUI for logparser. Download from here: https://lizard-labs.com/log_parser_lizard.aspx

	- This script is on GitHub: https://github.com/lizardlabs/Log-Parser-Lizard-Queries

HOW TO USE: 

	A) From command line:

	1) Change the paths you want to search after the FORM keyword
	2) Run logparser from command line: 
		
		C:\>LogParser -i:FS file:log4shell.search.MD5.sql

		
	B) Optionally, use Log Parser Lizard GUI (www.lizard-labs.com)

	1) copy and paste the script in Log Parser Lizard and click Run
	2) Modify the folders you want to search (after FROM)
	3) Click Run. You can export results in Excel for analysis/

NOTES: Alternatively, you can change the script to look for log4j*.jar files only instead of filtering by hashes.

*/


-- QUERY PROPERTIES: -i:FS

SELECT -- TOP 10000 -- limit the number of output records if needed
	Name, 
	Path, 
	EXTRACT_PATH(Path) AS Folder,
	ContentHashMD5
	USING
	HASHMD5_FILE(Path) AS ContentHashMD5


/***************************************************************************************
CHANGE THE LIST OF FOLDERS YOU WANT TO SEARCH: 

list of locations you want to search (use wildcard lof4j*.jar for better performance)
***************************************************************************************/

FROM 
	'c:\Program Files\log4j*.jar', 
	'c:\Program Files (x86)\log4j*.jar'


-- Filter known MD5 hashes. List of MD5 hashes is taken from here: https://github.com/mubix/CVE-2021-44228-Log4Shell-Hashes/blob/main/md5sum.txt (you may update the list if necesary)
WHERE 
to_lowercase(ContentHashMD5) IN
( 

-- # 2.X versions
'2addabe2ceca2145955c02a6182f7fc5'  -- ./apache-log4j-2.0-alpha2-bin/log4j-core-2.0-alpha2.jar
;'5b1d4e4eea828a724c8b0237326829b3'  -- ./apache-log4j-2.0-beta1-bin/log4j-core-2.0-beta1.jar
;'ce9e9a27c2a5caa47754999eb9c549b8'  -- ./apache-log4j-2.0-beta2-bin/log4j-core-2.0-beta2.jar
;'1538d8c342e3e2a31cd16e01e3865276'  -- ./apache-log4j-2.0-beta3-bin/log4j-core-2.0-beta3.jar
;'9cb138881a317a7f49c74c3e462f35f4'  -- ./apache-log4j-2.0-beta4-bin/log4j-core-2.0-beta4.jar
;'578ffc5bcccb29f6be2d23176c0425e0'  -- ./apache-log4j-2.0-beta5-bin/log4j-core-2.0-beta5.jar
;'5b73a0ad257c57e7441778edee4620a7'  -- ./apache-log4j-2.0-beta6-bin/log4j-core-2.0-beta6.jar
;'e32489039dab38637557882cca0653d7'  -- ./apache-log4j-2.0-beta7-bin/log4j-core-2.0-beta7.jar
;'db025370dbe801ac623382edb2336ede'  -- ./apache-log4j-2.0-beta8-bin/log4j-core-2.0-beta8.jar
;'152ecb3ce094ac5bc9ea39d6122e2814'  -- ./apache-log4j-2.0-beta9-bin/log4j-core-2.0-beta9.jar
;'cd70a1888ecdd311c1990e784867ce1e'  -- ./apache-log4j-2.0-bin/log4j-core-2.0.jar
;'088df113ad249ab72bf19b7f00b863d5'  -- ./apache-log4j-2.0-rc1-bin/log4j-core-2.0-rc1.jar
;'de8d01cc15fd0c74fea8bbb668e289f5'  -- ./apache-log4j-2.0-rc2-bin/log4j-core-2.0-rc2.jar
;'fbfa5f33ab4b29a6fdd52473ee7b834d'  -- ./apache-log4j-2.0.1-bin/log4j-core-2.0.1.jar
;'8c0cf3eb047154a4f8e16daf5a209319'  -- ./apache-log4j-2.0.2-bin/log4j-core-2.0.2.jar
;'8d331544b2e7b20ad166debca2550d73'  -- ./apache-log4j-2.1-bin/log4j-core-2.1.jar
;'5e4bca5ed20b94ab19bb65836da93f96'  -- ./apache-log4j-2.2-bin/log4j-core-2.2.jar
;'110ab3e3e4f3780921e8ee5dde3373ad'  -- ./apache-log4j-2.3-bin/log4j-core-2.3.jar
;'0079c907230659968f0fc0e41a6abcf9'  -- ./apache-log4j-2.4-bin/log4j-core-2.4.jar
;'f0c43adaca2afc71c6cc80f851b38818'  -- ./apache-log4j-2.4.1-bin/log4j-core-2.4.1.jar
;'dd0e3e0b404083ec69618aabb50b8ac0'  -- ./apache-log4j-2.5-bin/log4j-core-2.5.jar
;'5523f144faef2bfca08a3ca8b2becd6a'  -- ./apache-log4j-2.6-bin/log4j-core-2.6.jar
;'48f7f3cda53030a87e8c387d8d1e4265'  -- ./apache-log4j-2.6.1-bin/log4j-core-2.6.1.jar
;'472c8e1fbaa0e61520e025c255b5d168'  -- ./apache-log4j-2.6.2-bin/log4j-core-2.6.2.jar
;'2b63e0e5063fdaccf669a1e26384f3fd'  -- ./apache-log4j-2.7-bin/log4j-core-2.7.jar
;'c6d233bc8e9cfe5da690059d27d9f88f'  -- ./apache-log4j-2.8-bin/log4j-core-2.8.jar
;'547bb3ed2deb856d0e3bbd77c27b9625'  -- ./apache-log4j-2.8.1-bin/log4j-core-2.8.1.jar
;'4a5177a172764bda6f4472b94ba17ccb'  -- ./apache-log4j-2.8.2-bin/log4j-core-2.8.2.jar
;'a27e67868b69b7223576d6e8511659dd'  -- ./apache-log4j-2.9.0-bin/log4j-core-2.9.0.jar
;'a3a6bc23ffc5615efcb637e9fd8be7ec'  -- ./apache-log4j-2.9.1-bin/log4j-core-2.9.1.jar
;'0042e7de635dc1c6c0c5a1ebd2c1c416'  -- ./apache-log4j-2.10.0-bin/log4j-core-2.10.0.jar
;'90c12763ac2a49966dbb9a6d98be361d'  -- ./apache-log4j-2.11.0-bin/log4j-core-2.11.0.jar
;'71d3394226547d81d1bf6373a5b0e53a'  -- ./apache-log4j-2.11.1-bin/log4j-core-2.11.1.jar
;'8da9b75725fb3357cb9872adf7711f9f'  -- ./apache-log4j-2.11.2-bin/log4j-core-2.11.2.jar
;'7943c49b634b404144557181f550a59c'  -- ./apache-log4j-2.12.0-bin/log4j-core-2.12.0.jar
;'df949e7d73479ab717e5770814de0ae9'  -- ./apache-log4j-2.12.1-bin/log4j-core-2.12.1.jar
;'2803991d51c98421be35d2db4ed3c2ac'  -- ./apache-log4j-2.13.0-bin/log4j-core-2.13.0.jar
;'5ff1dab00c278ab8c7d46aadc60b4074'  -- ./apache-log4j-2.13.1-bin/log4j-core-2.13.1.jar
;'b8e0d2779abbf38586b869f8b8e2eb46'  -- ./apache-log4j-2.13.2-bin/log4j-core-2.13.2.jar
;'46e660d79456e6f751c22b94976f6ad5'  -- ./apache-log4j-2.13.3-bin/log4j-core-2.13.3.jar
;'62ad26fbfb783183663ba5bfdbfb5ace'  -- ./apache-log4j-2.14.0-bin/log4j-core-2.14.0.jar
;'3570d00d9ceb3ca645d6927f15c03a62'  -- ./apache-log4j-2.14.1-bin/log4j-core-2.14.1.jar
;'f5e2d2a9543ee3c4339b6f90b6cb01fc'  -- ./log4j-2.0-alpha1/log4j-core-2.0-alpha1.jar

-- # Possibly Vulnerable 1.x
;'4d4609998fbc124ce6f0d1d48fca2614'  -- ./apache-log4j-1.2.15/log4j-1.2.15.jar
;'4a11e911b2403bb6c6cf5e746497fe7a'  -- ./apache-log4j-1.2.16/log4j-1.2.16.jar
;'fb87bd84e336ca3dc6b6c108f51bf25e'  -- ./apache-log4j-1.2.17/log4j-1.2.17.jar
;'4a116eb60586d4163e3866edc02de4b3'  -- ./jakarta-log4j-1.0.4/log4j.jar
;'0c6ac98a9f2735db7e426eb35894d60a'  -- ./jakarta-log4j-1.0.4/log4j-core.jar
;'e9581a3b41ee050fab9256eb17c84bab'  -- ./jakarta-log4j-1.1.3/dist/lib/log4j.jar
;'c77f1f3db70f14deda3aa1b6f77ac764'  -- ./jakarta-log4j-1.1.3/dist/lib/log4j-core.jar
;'4d3c0c848b3765661fea690c4ab55577'  -- ./jakarta-log4j-1.2beta4/dist/lib/log4j-1.2beta4.jar
;'5bfbbff4bac4e8a035d553ef1663ee79'  -- ./jakarta-log4j-1.2rc1/dist/lib/log4j-1.2rc1.jar
;'a41bce4ac75fdba55a26cfccb9e3b8bf'  -- ./jakarta-log4j-1.2.1/dist/lib/log4j-1.2.1.jar
;'0fd5de3cfc23bac1798ca58835add117'  -- ./jakarta-log4j-1.2.2/dist/lib/log4j-1.2.2.jar
;'781359b1dea2e898179f40be29f63e0c'  -- ./jakarta-log4j-1.2.3/dist/lib/log4j-1.2.3.jar
;'98b84abac0f8b6fbcb4fdc42dc33f2c7'  -- ./jakarta-log4j-1.2.4/dist/lib/log4j-1.2.4.jar
;'0342459732ebdfc427d7288a39ea5538'  -- ./jakarta-log4j-1.2.5/dist/lib/log4j-1.2.5.jar
;'56e4cf9fabcc73bcece4259add1e3588'  -- ./jakarta-log4j-1.2.6/dist/lib/log4j-1.2.6.jar
;'8631619c6becebaac70862ac9c36af44'  -- ./jakarta-log4j-1.2.7/dist/lib/log4j-1.2.7.jar
;'18a4ca847248e5b8606325684342701c'  -- ./jakarta-log4j-1.2.8/dist/lib/log4j-1.2.8.jar
;'6a44d84b72897f28189f4792e2015b93'  -- ./logging-log4j-1.2.9/dist/lib/log4j-1.2.9.jar
;'1f441dc337a302406bc697ec1b57ac40'  -- ./logging-log4j-1.2.11/dist/lib/log4j-1.2.11.jar
;'223504f742addd3f631ed8bdf689f1c9'  -- ./logging-log4j-1.2.12/dist/lib/log4j-1.2.12.jar
;'52169b4a318e3246483f39f62b84b948'  -- ./logging-log4j-1.2.13/dist/lib/log4j-1.2.13.jar
;'599b8ba07d1d04f0ea34414e861d7ad1'  -- ./logging-log4j-1.2.14/dist/lib/log4j-1.2.14.jar
;'7b12acacd61b3fbf17e8031a2407c46b'  -- ./logging-log4j-1.3alpha-1/log4j-1.3alpha-1.jar
;'ab37ae9c53a099a229c94efbfce53f45'  -- ./logging-log4j-1.3alpha-3/log4j-1.3alpha-3.jar
;'f55f20a38c004a262423f06b30e76061'  -- ./logging-log4j-1.3alpha-5/log4j-1.3alpha-5.jar
;'ec6960de2fb51373bcea5ec107fcd55a'  -- ./logging-log4j-1.3alpha-6/log4j-1.3alpha-6.jar
;'3d430a2bf410c39019d253da5aaa979a'  -- ./logging-log4j-1.3alpha-7/log4j-1.3alpha-7.jar
;'2970dc6cee4b87d3fb987132039aae2f'  -- ./logging-log4j-1.3alpha-8/lib/log4j-1.3alpha-8.jar
;'a0594d1a36dcf6aa66859aacc5df463b'  -- ./logging-log4j-1.3alpha-8/lib/log4j-all-1.3alpha-8.jar
;'ddf718e2073a01d87cb0cc39805024ad'  -- ./logging-log4j-1.3alpha-8/lib/log4j-nt-1.3alpha-8.jar	
)



/*
WTFPL License (public domain): This program is free software. It comes without any warranty, to the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The F*ck You Want To Public License, Version 2, as published by Sam Hocevar. See
http://www.wtfpl.net/ for more details.
*/
