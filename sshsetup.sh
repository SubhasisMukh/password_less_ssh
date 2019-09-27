echo "Please enter the number of systems you want to setup passwordless SSH"
read number_of_systems
server_number=1
while [ $number_of_systems -gt 0 ]
do

	echo "Follow the instructions to setup passwordless ssh to server number "$server_number
	current_user=`whoami`
	echo "Please enter the username of the PC you want to setup passwordless SSH"
	read ssh_user
	echo "Please enter the IP address of the PC you want to setup passwordless SSH"
	read ssh_ip
	echo "======================================================="
	echo "If id_rsa already exists then don't overwrite"
	echo "======================================================="
	echo "ssh-keygen generate starting"
	echo "======================================================="
	ssh-keygen -t rsa
	echo "======================================================="
	echo "ssh-keygen generate done"
	echo "======================================================="
	echo "Started doing ssh passwordless"
	echo "======================================================="
	ssh $ssh_user@$ssh_ip mkdir -p .ssh
	echo "======================================================="
	echo ".ssh directory make done"
	echo "======================================================="
	cat /home/"$current_user"/.ssh/id_rsa.pub | ssh $ssh_user@$ssh_ip 'cat >> .ssh/authorized_keys'
	echo "======================================================="
	echo "public key paste done"
	echo "======================================================="
	ssh $ssh_user@$ssh_ip "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
	ssh -t $ssh_user@$ssh_ip 'exit && exec bash -l'
	echo "======================================================="
	echo "Passwordless SSH done"
	echo "======================================================="
	echo ""
	echo "Please try to run the following command from your PC: "  
	echo "=======================================================" 
	echo "ssh "$ssh_user"@"$ssh_ip
	echo "======================================================="
	number_of_systems=`expr $number_of_systems - 1`
	server_number=`expr $server_number + 1`
done