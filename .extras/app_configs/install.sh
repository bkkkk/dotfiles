BASEDIR=$(dirname "$0")

echo "Setting up Application Configs"

defaults import com.manytricks.Moom $BASEDIR/Moom.plist

defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "~/.alfred"
