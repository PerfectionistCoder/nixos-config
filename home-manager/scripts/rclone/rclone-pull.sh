BACKUP_HOME=${BACKUP_HOME?-'Missing variable BACKUP_HOME'}
BACKUP_NAME=${BACKUP_NAME?-'Missing variable BACKUP_NAME'}
remote=${1?-'Missing name of the remote'}

cd $BACKUP_HOME
if [ -d "$BACKUP_NAME" ] && [ -n "$(ls -A $BACKUP_NAME)" ]; then
  time=$(date '+%d-%b-%Y_%X')
  tar --force-local -czf "$time.tar.gz" -C $BACKUP_NAME .
else
  mkdir $BACKUP_NAME
fi

working_dir=/tmp/$$
rclone sync $remote $working_dir
trap "rm -rf $working_dir" EXIT
cd $working_dir

backup_dir=$BACKUP_HOME/$BACKUP_NAME

rm -rf $backup_dir/*
for item in *; do
  if [[ $item =~ .*\.gpg ]]; then
    name=${item%'.gpg'}
    gpg -o $name -d $item
    tar -xzf $name
    mv ${name%'.tar.gz'} $backup_dir
  else
    mv $item $backup_dir
  fi
done
