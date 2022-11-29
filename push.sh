shellScriptFolder=$(dirname "$0")
cd $shellScriptFolder
pwd

# 先部署到github
# hexo clean
hexo g 
git add .
git commit -m "update"
git push 

# 然后部署到ipfs，需要把部署路径修改一下，包括url和root。
# idString=`ipfs id`
# str="ID\": \""
# subIdStr=${idString#*$str}
# str1="\","
# IPFS_ID=${subIdStr%%$str1*}
# echo $IPFS_ID
# sed -i "" "/root: / s/\/blog\//\/ipns\/${IPFS_ID}\//" _config.yml
# sed -i "" "/url: / s/http:\/\/liuqinh2s.github.io\/blog/http:\/\/ipfs.io\/ipns\/${IPFS_ID}/" _config.yml
# hexo clean
# hexo g
# string=`ipfs add -r docs/`
# subStr=${string##*added }
# ROOT_DIR_HASH=${subStr% docs}
# ipfs name publish $ROOT_DIR_HASH

# 再把url和root改回来
# sed -i "" "/root: / s/\/ipns\/$IPFS_ID\//\/blog\//" _config.yml
# sed -i "" "/url: / s/http:\/\/ipfs.io\/ipns\/$IPFS_ID/http:\/\/liuqinh2s.github.io\/blog/" _config.yml

# cd -