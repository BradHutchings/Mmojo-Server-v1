## 12. Create Mmojo Share

Brad Hutchings<br/>
brad@bradhutchings.com

---
### Create Mmojo Share
The Mmojo Share is a file share where I keep files for local access and completed builds. It lets me build different items on different build platforms. I use a Ubuntu 24.04 virtual machine to build and test x86_64 and cosmo builds. I use a Raspberry Pi for building and testing ARM64 and Pi specific builds, including with Vulkan support. The Mmojo Share lets me keep .gguf models to test with locally and is where I copy completed and packaged builds. Your Mmojo Share will help you organize your builds as well.

1. Create an SMB share on a computer on your network. It should have a user and password so you can access it from your build systems. Write down the hostname of the computer, and the user that can access the share.
2. We need some variables:
   ```
   SHARE_DIR="/mnt/mmojo"
   SCRIPTS_DIR="$HOME/scripts"
   TILDE_SCRIPTS="~/scripts"
   MOUNT_SCRIPT="mount-mmojo-share.sh"
   ```
4. Create `/mnt/mmojo` directory.
   ```
   if [ ! -d "$SHARE_DIR" ]; then
       sudo mkdir -p $SHARE_DIR
   fi
   ```
5. Create `$HOME/scripts` directory.
   ```
   if [ ! -d "$SCRIPTS_DIR" ]; then
       mkdir -p $SCRIPTS_DIR
   fi
   ```
6. Create a `mount-mmojo-share.sh` script, edit with your details.
   ```
   cat << EOF > "$SCRIPTS_DIR/$MOUNT_SCRIPT"
   if [[ ! \$(findmnt $SHARE_DIR) ]]; then
       sudo mount -t cifs -o user=[USER] //[COMPUTER]/mmojo $SHARE_DIR
   fi
   EOF
   chmod a+x "$SCRIPTS_DIR/$MOUNT_SCRIPT"
   ```
7. Edit the script to put your `COMPUTER` and `USER` names in. "Ctrl-X" then "Y" to exit and save.
   ```
   nano "$SCRIPTS_DIR/$MOUNT_SCRIPT"
   ```
9. If `~/scripts` is not already in the `$PATH`, add `~/scripts` to your `$PATH` in `.bashrc` and `source` `.bashrc`.
   ```
   if [[ "${PATH}" != *"${SCRIPTS_DIR}"* ]] && [[ "${PATH}" != *"${TILDE_SCRIPTS}"* ]]; then
   cat << EOF >> $HOME/.bashrc
   export PATH="$PATH:$SCRIPTS_DIR"
   EOF
   source $HOME/.bashrc
   fi
   echo $PATH
   ```

---
### Proceed
**Up:** [10. Prepare Build Environment](NEW-10-Prepare-Build-Environment.md)
- **Previous:** [11. Set Timezone](NEW-11-Set-Timezone.md)
- **Next:** [13. Install Dependencies](NEW-13-Install-Dependencies.md)

