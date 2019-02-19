#!/bin/bash
#
#********************************************************************
#Author:		weipingyang
#QQ: 			812756780
#Date: 			2019-02-19
#FileName：		createscript.sh
#URL: 			https://wpynb.github.io
#Description：		The test script
#Copyright (C): 	2019 All rights reserved
#********************************************************************
cat > $1 <<EOF
#!/bin/bash
#
#********************************************************************
#Author:                weipingyang
#QQ:                    812756780
#Date:                  2019-02-19
#FileName：             createscript.sh
#URL:                   https://wpynb.github.io
#Description：          The test script
#Copyright (C):         2019 All rights reserved
#********************************************************************

EOF
chmod +x $1
vim + $1
