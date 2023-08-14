#!/bin/bash
#asking the user to enter username and id as a parameter(just kind of command line argument.)
username=$1
id=$2

#playAgain function (asks user to play again or not)
playAgain()
{
    echo
    echo -e "Do you want to play again? Input (yes/y) to play again and (no/n) to exit: \c"
    read againValue
    #checking empty string
    if [ -z $againValue ]
    then
        echo -e "Do not leave it empty."
        playAgain
    else
        #converting to upper case
        againValue=${againValue^^}
    fi    
    
    if [ $againValue == "YES" ] || [ $againValue == "Y" ]
    then
        codeForBands
    elif [ $againValue == "NO" ] || [ $againValue == "N" ]
    then
        exit
    else
        echo -e "Choose only y/n or yes/no."
        playAgain
    fi

}

#select the members and disply the content of the file selected.
menuOfMembers()
{
    PS3="Choose your favourite member from these options: "
    select memberBand in $bandMemberOne $bandMemberTwo $bandMemberThree
    do
        case $memberBand in 
        KC | AY | JL)
        #opens file of the option selected
            cat $memberBand
            break
            ;; 

        *)
            echo -e "Sorry. Wrong input."
            echo
            ;;
        esac
    done
    playAgain
}


#function to display band memebers
codeForMembers()
{
    echo
    echo -e "---------------------"
    echo -e "Codes for members: "
    echo -e "---------------------"
    echo -e "John Lennon:     JL"
    echo -e "Angus Young:     AY"
    echo -e "Freddie Mercury: FM"
    echo -e "Debbie Harry:    DH"
    echo -e "Kurt Cobain:     KC"
    echo -e "---------------------"

    echo
    echo -e "Choose only 3 members from the given options: \c"
    read bandMemberOne bandMemberTwo bandMemberThree bandMemberFour

    choiceForMembers
    
}

#function to choose band members
choiceForMembers()
{
    #checking empty string
    if [ -z $bandMemberOne ] || [ -z $bandMemberTwo ] || [ -z $bandMemberThree ]
    then
        echo -e "Error!!!Do not leave it empty."
        codeForMembers
    
    #to restrict for 3 members
    elif [ $bandMemberFour ]
    then
        echo -e "Error!!!Can only select 3 members."
        codeForMembers

    #checking if all the input or same or not
    elif [ "$bandMemberOne" == "$bandMemberTwo" ] || [ "$bandMemberTwo" == "$bandMemberThree" ] || [ "$bandMemberThree" == "$bandMemberOne" ]
    then
        echo -e "Error!!!The members cannot be the same. The members must be different at every input."
        codeForMembers

    #checking if the input is from the given options or not
    elif [ "$bandMemberOne" != "JL" ] && [ "$bandMemberOne" != "AY" ] && [ "$bandMemberOne" != "FM" ] && [ "$bandMemberOne" != "DH" ] && [ "$bandMemberOne" != "KC" ]
    then 
        echo -e "Error!!!Select members from the given options."
        codeForMembers

    #checking if the input is from the given options or not
    elif [ "$bandMemberTwo" != "JL" ] && [ "$bandMemberTwo" != "AY" ] && [ "$bandMemberTwo" != "FM" ] && [ "$bandMemberTwo" != "DH" ] && [ "$bandMemberTwo" != "KC" ]
    then 
        echo -e "Error!!!Select members from the given options."
        codeForMembers
    
    #checking if the input is from the given options or not
    elif [ "$bandMemberThree" != "JL" ] && [ "$bandMemberThree" != "AY" ] && [ "$bandMemberThree" != "FM" ] && [ "$bandMemberThree" != "DH" ] && [ "$bandMemberThree" != "KC" ]
    then 
        echo -e "Error!!!Select members from the given options."
        codeForMembers

    else
        menuOfMembers   
    
    fi
 
}

#function to choose a band
choiceForBands()
{
    if [ -z $bandCode ]
    then
        echo -e "Error!!!Do not leave it empty.Please choose a band."
        codeForBands
        
    #band to be seleced is nirvana and the code is NIR
    elif [ $bandCode == "NIR" ]
    then 
        #opens file NIR to display the contents in it
        
        echo -e "
Nirvana was an American rock band formed in Aberdeen, Washington, in 1987. 
Founded by lead singer and guitarist Kurt Cobain and bassist Krist Novoselic, the band went through a succession of drummers, most notably Chad Channing, before recruiting Dave Grohl in 1990. 
Nirvana's success popularized alternative rock, and they were often referenced as the figurehead band of Generation X. 
Their music maintains a popular following and continues to influence modern rock culture.
"
        codeForMembers
        
    else
        echo "Error!!!Incorrect input."
        codeForBands

    fi
}

#function to display band codes
codeForBands()
{
    echo
    echo -e "-----------------"
    echo -e "Codes for bands: "
    echo -e "-----------------"
    echo -e "Beatles: BEA"
    echo -e "AC/DC:   AD"
    echo -e "Queen:   QUE"
    echo -e "Blondie: BLO"
    echo -e "Nirvana: NIR"
    echo -e "-----------------"
    echo

    echo -e "Choose the band from the given options: \c"
    read bandCode

    #calling choiceforBands function
    choiceForBands

}

# welcome fucntion to print username and id of the user and date after access through secret key
welcome()
{
    echo
    echo -e "----------------------------------------------"
    echo -e "ID:            $id"
    echo -e "Username:      $username"
    echo -e "Date and Time: "$(date)
    echo -e "----------------------------------------------"

    codeForBands
}

#validating username and id
#checking empty or not
if [ -z $username ] || [ -z $id ]
then
    echo -e "Error!!! Username or ID is missing."
#username = sayush, id = 1
elif [ $username != sayush ] || [ $id != 1 ]
then 
    echo -e "Error!!!Wrong username or user id."
    
else

    attempt=0
    secretKey=0 
    #secret key = 1234
    while [ $secretKey != 1234 ] 
    do
        #runs the loop 3 times
        if [ $attempt -le 3 ]
        then
        echo
            echo -e "Enter the secret key: \c"
            read -s secretKey #to hide the value of secretKey
            echo  

            #checking if the secret key is empty
            if [ -z $secretKey ]
            then    
                echo "Error!!!Do not leave the secret key empty."
                attempt=$(( $attempt+1 ))
                #secret key value set to 0 again
                secretKey=0

            elif [ $secretKey == 1234 ]
            then
                break

            else
                echo -e "Error!!!The entered secret key does not match the real secret key."
                attempt=$(( $attempt+1 ))
            fi

        else
            echo
            echo "The program is closed."
            exit
        fi

    done
    #calling welcome function
    welcome

fi
