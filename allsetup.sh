#!/bin/bash

wpath=/home/deploy/wrk/digitory

#digitoryapi_branch=sas-06Sep2019-packagingSize
digitoryapi_branch=sas-15Oct2019-subRecipeChange
#digitorywebv2_branch=sb-27Sept-ps-merge
digitorywebv2_branch=asn-10Oct2019-PrintIntegration
#digitorypp_branch=sb_pipenv_2oct
digitorypp_branch=sas-11Oct2019-improvments
utilities_branch=master

admin_username=admin
admin_password=password
admin_email=admin@digitory.com

masterdatafolder=$wpath/md

echo "                                                 "
echo "================================================="
echo "Make sure the newinstall.sh script from utilities has been run"
echo "Confirm (Y/N), followed by [ENTER]:"
read r0
if [ "$r0" == "Y" ] || [ "$r0" == "y" ]
then
    echo "Ok, you can continue"
else
    echo "Not OK, exiting now. Please run script newinstall.sh first"
fi

echo "                                                 "
echo "================================================="
echo "changing working path to : $wpath"
cd $wpath

echo " Start the ssh agent if its not running"
eval `ssh-agent`

echo "                                                 "
echo "================================================="
echo "dropping the old ssh keys"
ssh-add -D

echo "                                                 "
echo "================================================="
echo "adding digitory keys"
ssh-add keys/SudhanshuKilledarDigitory


echo " Fresh install? Do you need to clone?"
echo "Confirm (Y/N), followed by [ENTER]:"
read r1

if [ "$r1" == "Y" ] || [ "$r1" == "y" ]
then
    	echo "Ok, cleaning up any old directories if there"
    	/bin/rm -rf ./digitoryapi ./digitorywebv2 ./digitorypp ./utilities
    	echo "Ok, cloning directories now"
	echo "                                                 "
	echo "================================================="
	echo "checking out code"

	# display package names
	echo "                                                 "
	echo "================================================="
	echo "cloning digitoryapi" 
	git clone git@bitbucket.org:digitorytech/digitoryapi.git

	echo "                                                 "
	echo "================================================="
	echo "cloning digitorywebv2" 
	git clone git@bitbucket.org:digitorytech/digitorywebv2.git

	echo "                                                 "
	echo "================================================="
	echo "cloning digitorypp"
	git clone git@bitbucket.org:digitorytech/digitorypp.git

	echo "                                                 "
	echo "================================================="
	echo "cloning utilities"
	git clone git@bitbucket.org:digitorytech/utilities.git



	echo "Now change branches"
        echo "                                                 "
        echo "================================================="
        echo "checking out proper branches"

        echo "1. digitoryapi : $digitoryapi_branch"
        cd $wpath
        cd digitoryapi
        git checkout $digitoryapi_branch

        echo "2. digitorywebv2 : $digitorywebv2_branch"
        cd $wpath
        cd digitorywebv2
        git checkout $digitorywebv2_branch

        echo "3. digitorypp : $digitorypp_branch"
        cd $wpath
        cd digitorypp
        git checkout $digitorypp_branch

        echo "4. utilities : $utilities_branch"
        cd $wpath
        cd utilities
        git checkout $utilities_branch

else
    	echo "Not cloning - just skip ahead to change branches"
	echo "                                                 "
	echo "================================================="
	echo "checking out proper branches"

	echo "1. digitoryapi : $digitoryapi_branch"
	cd $wpath
	cd digitoryapi
	git checkout $digitoryapi_branch

	echo "2. digitorywebv2 : $digitorywebv2_branch"
	cd $wpath
	cd digitorywebv2
	git checkout $digitorywebv2_branch

	echo "3. digitorypp : $digitorypp_branch"
	cd $wpath
	cd digitorypp
	git checkout $digitorypp_branch

	echo "4. utilities : $utilities_branch"
	cd $wpath
	cd utilities
	git checkout $utilities_branch

fi

cd $wpath
echo $pwd

echo "                                                 "
echo "================================================="
echo "enter name of test"
read testname
testname_digitory_db="${testname}_digitory_db"

#export DB_SERVER=139.59.33.75
export DB_SERVER=localhost
export DB_PORT=27017
#export DB_NAME=digi-17Oct-rc2
export DB_NAME=${testname_digitory_db}

. ~/.bashrc
env | grep DB

echo "create a new window and run rails using following command"
# startup the API
# using the exported variables
cd $wpath/digitoryapi

(nohup rails s --binding=0.0.0.0 -p 3000 &)&
echo "rails process starting"
echo "$!"

echo "                                                 "
echo "================================================="
echo "enter name of tenant"
read tenantname
testtenantname="${tenantname}${testname}"

cd $wpath/utilities/DataImportScripts/demoSetupScripts
echo "current path = $PWD"

masterdatadir=../demoMasterData
branchfile=branches.csv
branchfilename=${masterdatadir}/${branchfile}
echo $branchfilename


echo "creating databases, setting up tenantid, tenantname, adminuser, adminemail, adminpassword, and creating branches "
#python3 updateTenant.py digi-17Oct-rc1 tenant-displayname-17oct-rc1 tid-17Oct-rc1 admin admin@digitory.com admin ../demoMasterData/branches.csv
python3 updateTenant.py $testname_digitory_db $testtenantname $testtenantname $admin_username $admin_email $admin_password $branchfile

# branches 
# users 
# inventory
# menuitems
# recipes
# vendors
# vendor inventory
# packages


echo "running deployment package for front end code"



echo "run jobs.py in a new window using following command"


