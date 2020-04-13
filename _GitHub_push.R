# SETUP ENVIRONMENT -------------------------------------------------------
# setup libraries
library("git2r")
# instructions on how to use git2r package here https://rpubs.com/chrimaho/GitHubAutomation
library("keyring")
# you will need to make sure the "GITHUB_USER" keyring is setup
# instructions here https://rdrr.io/cran/keyring/man/backend_wincred.html 
# and more on the keyring package here https://www.r-bloggers.com/how-to-hide-a-password-in-r-with-the-keyring-package/
# setup working directory
working_directory <- "U:/COVID19_Analysis"
GitHub_filepath <- paste0(working_directory, "/")
setwd(working_directory)
workdir(working_directory)

# 1. CREATE GITHUB.R FILE -------------------------------------------------
writeLines(paste0(format(Sys.time(), "%Y-%m-%d %H:%M:%S"), ": Creating GitHub.R file"))
FileConnection <- file(GitHub_filepath)
close(FileConnection)
rm(FileConnection)

# 2. STAGE CHANGES --------------------------------------------------------
writeLines(paste0(format(Sys.time(), "%Y-%m-%d %H:%M:%S"), ": Staging changes"))
add(repo = getwd(), path = GitHub_filepath)

# 3. COMMIT CHANGES -------------------------------------------------------
writeLines(paste0(format(Sys.time(), "%Y-%m-%d %H:%M:%S"), ": Comitting changes"))
commit(repo = getwd(), message = "Updating data")

pull(repo = getwd(), credentials = cred_user_pass(username = "buntoss@gmail.com", password = key_get("GITHUB_USER", "buntoss@gmail.com")))

# 4. PUSH CHANGES ---------------------------------------------------------
writeLines(paste0(format(Sys.time(), "%Y-%m-%d %H:%M:%S"), ": Pushing changes"))
push(object = getwd(), credentials = cred_user_pass(username = "buntoss@gmail.com", password = key_get("GITHUB_USER", "buntoss@gmail.com")))



