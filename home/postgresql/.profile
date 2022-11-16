PGUSER=postgres
export PGUSER

stty -echo
printf "DBA manager password: "
read PGPASSWORD
stty echo
printf "\n"

export PGPASSWORD

trap "$HOME/.logout" 0 
