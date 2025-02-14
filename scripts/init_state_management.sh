#!/bin/bash

echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------"
echo "------------MyCompany - Infrastructure automation------------"
echo "-------- initial terraform state management and state locks --------"
echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------
"

# define Resource name
if [ -z "$1" ]
  then
    echo "Resource name is required"
    sleep 5s
    exit 0
fi
RESOURCE_NAME=$1

# define AWS profile
if [ -z "$3" ]
  then
    echo "aws profile was not provided, using default"
    AWS_PROFILE=default
  else
    echo "aws profile was provided, using profile $3"
    AWS_PROFILE=$3
fi

declare -x PROFILE_COMMAND=""
if [ "$AWS_PROFILE" != "default" ]
  then 
    $PROFILE_COMMAND="--profile $AWS_PROFILE"
fi

datetime=⁠ TZ='Asia/Mumbai' date ⁠
CREATIONTIME="$datetime"