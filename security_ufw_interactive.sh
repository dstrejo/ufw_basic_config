#!/bin/bash

# Basic interactive script to set firewall rules in ufw. 

# Function to check current status and pompt user with options.
#
show_options(){
	if      sudo ufw status | grep -w "inactive" ; then
		
	        echo -e "Firewall is currently disabled\n"
		read -p "To enable it and continue with the congiuration select 1. Press any other key to exit " aux
		
		if [ $aux -eq 1 ]; then
			sudo ufw enable
			sudo ufw status numbered
			select_option
		else

			exit 1

		fi

 	else 
	       sudo ufw status numbered
               select_option
fi	

}

select_option(){
  echo -e "Select any of the options below to continue:\n"
    echo "Add a new rule: 1"
    echo "Delete a rule : 2"
    echo "Reset firewall: 3"
    echo "Exit: 4"
    read -p "Enter your choice: " option_chosen
    echo -e "\n\tYou have selected option $option_chosen"
    
    case "$option_chosen" in
        1)
            add_rule
            ;;
        2)
            delete_rule
            ;;
        3)
            reset_firewall
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option selected!"
            ;;
    esac
    select_option  # Prompt again after completing the action
}

add_rule (){
	read -p "Do you want to allow or deny traffic? Enter allow or deny: " first_parameter
	read -p "Enter the protocol or port you want to allow or deny. For example, enter ssh (22) or http (80): " second_parameter
	sudo ufw $first_parameter $second_parameter
	 if [ $? -eq 0 ]; then
        	echo "Rule has been set."
    	else
        	echo "Failed to set rule."
    	fi

}

delete_rule(){
	sudo ufw status numbered
	read -p "Enter the number linked to the rule on the list above: " remove_rule
	sudo ufw delete $remove_rule


	if [ $? -eq 0 ]; then
        	echo "Rule $remove_rule has been successfully removed."
		sudo ufw status numbered
    	else
        	echo "Failed to remove rule."
   	fi
}

reset_firewall(){
	read -p "Are you sure you want to reset to default? Type yes or no: " confirmation
	if [ "$confirmation" == "yes" ]; then
		sudo ufw reset
	fi
}
# Main loop
show_options
