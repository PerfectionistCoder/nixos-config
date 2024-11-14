multipass() {
    export PASSWORD_STORE_DIR="$PASSWORD_STORE_DIR/$1"
    shift
    pass "$@"
}

multipass "$@"
