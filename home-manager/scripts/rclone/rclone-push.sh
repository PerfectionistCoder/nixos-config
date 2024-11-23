BACKUP_HOME=${BACKUP_HOME?-'Missing variable BACKUP_HOME'}
BACKUP_NAME=${BACKUP_NAME?-'Missing variable BACKUP_NAME'}

backup_dir=$BACKUP_HOME/$BACKUP_NAME

if [ ! -d "$backup_dir" ]; then
  echo Backup directory missing
  exit 1
elif [ -z "$(ls -A $backup_dir)" ]; then
  echo Backup directory is empty
  exit 2
fi

cd $backup_dir

WORKING_DIR=/tmp/$$
mkdir $WORKING_DIR
trap "rm -rf $working_dir" EXIT

for item in *; do
  if [ -f $item ]; then
    cp $item $WORKING_DIR
  elif [ -d $item ]; then
    name="$item.tar.gz"
    tar -czf $name $item
    gpg -o $name.gpg -r ${2?-'Missing name of gpg key'} -e $name
    rm $name
    mv $name.gpg $WORKING_DIR
  fi
done

rclone sync $WORKING_DIR ${1?-'Missing name of remote'}
