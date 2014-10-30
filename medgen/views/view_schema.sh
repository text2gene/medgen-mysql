. db.config 

$mysql_dataset -e "call log('call etime','for a good elapse time')"
$mysql_dataset -e "call log('call etime','call mem')"

echo "============================" 
echo "tail database app log " 
echo "============================" 
$mysql_dataset -e "call etime" 

echo "============================" 
echo "memory usage with DB Schema " 
echo "============================" 
$mysql_dataset -e "call ps" 
$mysql_dataset -e "call mem" 

