 
#!/bin/sh

#Bash scripting is better than firing up python or R. It'll manipulate files 
#ie rename sort move without have to fireing up either and reading in all data
# this will be handy when working in the cloud!

##########################################################################
#################################CREATEING VARIABLES#####################
echo "scripting is fun" #echo is like a print
x="Shell Scripting is Fun!"  #set variables with no space

echo ${x} #reference variables with brackets ${}

y=$(hostname) #outputs of commands can be set thru $()


#notice how  ${} or $ () interupts the quites and puts om either variable or call to function
echo "this  script is running on ${y}. where $(hostname) is the output of the  hostname command"
 


#############################################################################
##################################IF THEN LOGIC###############################
#spaceing is  important other wise arguments are confused. 
#instead of  test  [ ]  can also be used  ie...

test -e /etc/shadow

if [ -e /etc/shadow.txt ] #[-e file]  test if a file is present
then echo "yes I see it"
else echo "there is no file"
fi


if [ -w /etc/shadow.txt ] #[w file.name] test of a file is writeable 
then echo "...and the file is writable"
else echo "file is not writable either"
fi



#the #1 thru $9 allows arguments to be used and referenced when running the
# a script #print out the first second third and 4th user supplied argument(s)
echo $1
echo $2
echo $3
echo $4


####################################################################################
#############################STANDARD INPUT FROM USE#############################
#read in an input named after the variable FILE 
#and then inspect it downstream with if logic
## read -p <PROMPT> <variable.name>

read -p "What is the name of the file you're looking for " FILE
echo "looking For file ${FILE}"


if [ -e ${FILE} ] #[-e $1 ] would have made this and argument supplied with no prompt
then echo "is see it"
else echo "I dont see this file"
fi


if [ -f ${FILE} ] #[-e $@ ] allows for a list of arguments supplied with no prompt
then echo  "i see it...it happens to be a regular file"
fi

########################################################################################
##################################EXIT STATUSES########################################
echo "this script  will exit with a  0 exit status"
#exit 0

read -p " please enter the file you want me to test for validity " FILE

if [ -f ${FILE} ] ; then echo "exit 0"
#exit 0
fi

if [ -d ${FILE} ]; then echo "exit 1"
#exit 1
fi

if [ -f !${FILE} ] || [ -d !${FILE} ]; then echo "exit 2"
#exit 2
fi




# execute the cat command on the  following file if 
# the exit status is 0 indicating success then print  hurray
# otherwise print failure and set exit status to 1
cat /etc/shadow

if [ $? -eq 0 ]; then
echo "exit status is 0 hurray"
#exit 0
else
echo "exit status is not 0 something went wrong"
#exit 1
fi


########################################################################################
################################FUNCTIONS###############################################

# to count files in a directory save files to a variable
# then subset that variable? 
function file_count()
{
#shopt -s nullglob
numfiles=$(ls *.*)
local dir="$1"        #this allows a directory to be entered
echo "counting files in the directory $dir"
local count=$(ls -1 $dir | wc -l)   # | is  is a pipe similar to %> in R  
echo "the number of files in $dir is  $count"
}

file_count /Users/jabba/Desktop/Bioinformatic
