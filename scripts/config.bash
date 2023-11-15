NAME='mirek'
SURNAME='binas'

function here(){
    echo "this will be executed"
    date
}

function main(){
    printf "the program starts here\n"
    here
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi