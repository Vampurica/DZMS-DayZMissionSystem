**[DZMS] DayZ Mission System**
================

A Logic and Usability Rewrite of the DayZChernarus Mission System.

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

5.	Open up your server_functions.SQF in the init folder in your server.PBO.

	Search for the code block
	```dayz_recordLogin = {
		private["_key"];
		_key = format["CHILD:103:%1:%2:%3:",_this select 0,_this select 1,_this select 2];
		_key call server_hiveWrite;
	};```
	
	And insert this line below it.
	```call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZMS\DZMSInit.sqf";```

6.	Now just rePack your PBO and enjoy!

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
