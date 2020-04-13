# 1. INSTRUCTIONS ---------------------------------------------------------
# this script is needed to interact with GitHub (e.g. _GitHub_push.R) and the "keyring" package
# the purpsoe of the script is to setup the "GITHUB_USER" keyring 
# more on the keyring package here https://www.r-bloggers.com/how-to-hide-a-password-in-r-with-the-keyring-package/
# load keyring package
library(keyring)
# Store email username with password (EXAMPLE BELOW)
# key_set_with_value(service = "user_email", 
                   #username = "your_address@example.com",
                   #password = "test password")

# 2. UPDATE PASSWORD FOR BUNTOSS ------------------------------------------
# enter the password for the keyring (DONT SAVE PASSWORD)
password <- #ENTER PASSWORD HERE

# 3. SETUP GITHUB KEYRING -------------------------------------------------
# Store email username with password (ACTUAL SCRIPT FOR SETUP)
key_set_with_value(service = "GITHUB_USER", 
                   username = "buntoss@gmail.com",
                   password = password)				   
				   
# 4. REMOVE PASSWORD ------------------------------------------------------
rm(password)
