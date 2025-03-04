start_all:
	VBoxManage startvm cafwfrontend --type headless
	VBoxManage startvm cafwbackend --type headless
	VBoxManage startvm caserver02 --type headless
	VBoxManage startvm caserver01 --type headless

stop_all:
	VBoxManage controlvm cafwfrontend acpipowerbutton
	VBoxManage controlvm cafwbackend acpipowerbutton
	VBoxManage controlvm caserver02 acpipowerbutton
	VBoxManage controlvm caserver01 acpipowerbutton