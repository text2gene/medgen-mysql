echo "##########################################"
echo ""
echo "Create MySQL User"
echo ""
echo "This script generates a mysql user that will be used across all databases."
echo ""
echo "Requires SUPERUSER privileges, i.e. a root password."
echo "      (if no password, hit Enter at password prompt.)"
echo ""

mysql -u root -p < create_user.sql

echo ""
echo "Done!"
echo "//////////////////////////////////////////"
echo ""

