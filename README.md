**[DZMS] DayZ Mission System**
================

A Logic and Usability Rewrite of the DayZChernarus Mission System.

Current Version is Release Client 1.0

If you are interested in helping, please contact me on OpenDayz.net.

--------------------------
Installation
--------------------------
1.	Download the Github Zip folder and open it with your unPacker of choice.

	> https://github.com/SMVampire/DZMS-DayZMissionSystem/archive/master.zip
	
2.	Extract it to your Desktop or somewhere where you won't lose it.
	Inside the Zip is this Readme.MD and a folder called DZMS.
	
3.	Open your Server.PBO with the PBO unPacker of your choice.

4.	Put the "DZMS" folder into your Server.pbo.

5.	Open up your server_moniter.SQF in the system folder in your server.PBO.

	Search for this line
	
	```allowConnection = true;```
	
	And insert this line directly above it.<br />
	```[] ExecVM "\z\addons\dayz_server\DZMS\DZMSInit.sqf";```
	
	If you have DZAI or WickedAI Installed, the DZMS line should go under theirs.
	
6.	(Optional) Change the settings in DZMSConfig.SQF.

7.	(Optionally Optional) Adjust the files in the ExtConfig folder.
	
8.	Now just rePack your PBO and enjoy!

--------------------------
Current Developers
--------------------------
* Vampire - Head Developer - http://opendayz.net/members/vampire.13088/

--------------------------
Credits
--------------------------
* TAW_Tonic - One of the Original DayZ Mission Developers. - http://sealteamsloth.com/
* TheSzerdi - One of the Original DayZ Mission Developers. - http://opendayz.net/members/theszerdi.3761/
* Lazyink - Modified the Original Mission system to work on Chernarus. - http://opendayz.net/members/lazyink.3595/
