#!/bin/bash
{
	# execute updates for all the existent files
	yum -y update
	yum install git -y
	yum install nano -y 	

	replace_key_value_pair()
	{
   		 local key=$1
   		 local separator=$2
    		 local value=$3
    		 local source_file=$4

		 # [^...] match any character that is not in that set
    		 if grep -q "^[^#]\?$key$separator" $source_file; then

			# sed = Stream Editor
			# -i = in-place (save back to the original file)
			# s = substitute command, g = global
			# sed -i 's/original/new/g' file.txt

        		sed -i "s/^[^#]\?$key$separator.*/$key$separator$value/g" $source_file  
    	         else
        		echo "$key$separator$value" >> $source_file
    		 fi
   		 return 0
	}

	configure_ipv4_addresses()
	{
		local operation_status

		# operation_status= nmcli con mod $connection ipv4.method manual
		# operation_status= $operation_status && nmcli con mod $connection ipv4.addresses $machine_ip
		# operation_status= $operation_status && nmcli con mod $connection connection.autoconnect yes
		# operation_status= $operation_status && nmcli con down $connection
		# operation_status= $operation_status && nmcli con up $connection

		operation_status= ifup enp0s3
		operation_status= $operation_status && ifup enp0s8
		return $operation_status
	}

	#disable the authentication though username and password
	disable_auth_pass()
	{
    
    		local key="PasswordAuthentication"
    		local value="no"
    		local operation_status

    		operation_status= replace_key_value_pair $key " " $value /etc/ssh/sshd_config
		operation_status=$operation_status && service sshd restart
		return $operation_status
	}

	# we are ensuring that selinux is setted to disabled and after that we are going to change the status
	setup_selinux()
	{
    		local operation_status

    		operation_status= replace_key_value_pair "SELINUX" "=" "disabled" /etc/selinux/config
   	 	operation_status=$operation_status && setenforce 0
    		operation_status= replace_key_value_pair "SELINUX" "=" "enforcing" /etc/selinux/conf
   		return $operation_status
	}

	operation_status=setup_selinux
	if $operation_status ; then
		echo "SELINUX attribute has now the status enforcing"
	else
		echo "Failure on setting the SELINUX attribute to enforcing"
	fi
	
#	operation_status=disable_auth_pass
#	if $operation_status ; then
#		echo "Authentication is possible now only through ssh keys"
#	else
#		echo "Failure during disabling password_authentication"
#	
#	fi 

	operation_status=configure_ipv4_addresses
	if $operation_status ; then
		echo "Network ipv4 addresses configured successfully"
	else
		echo "Failure during the process of configuration the ipv4 addreses"
	fi

}>>/var/log/system-bootstrap.log
