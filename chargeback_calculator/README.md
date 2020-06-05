# Deploy to RStudio Connect
You can deploy this app directly to your RStudio Connect instance using
[git-backed deployment](https://docs.rstudio.com/connect/user/git-backed/). The URL will be https://github.com/sol-eng/connect-user-management.git.

On first deploy, the app will fail and you will have to define the `CONNECT_SERVER` and `CONNECT_API_KEY` [environment vars](https://docs.rstudio.com/connect/user/content-settings/#content-vars).

Your `CONNECT_SERVER` is the URL of your RStudio Connect server. Instructions for getting an API key to use in the `CONNECT_API_KEY` are in the [RStudio Connect User Guide](https://docs.rstudio.com/connect/user/api-keys/).

# Edit the App Before Deploying
If you want to edit the app before deploying to RStudio Connect, you will have to prepare your package environment.

1) Open the chargeback_counter project by opening the `chargeback_counter.Rproj` in the RStudio IDE.
2) Restore the R packages by running `renv::restore`.
  - If you are on a Linux system, you may wish to change the restore to use binary packages from RStudio Package Manager, as installs will be much faster. You can do this by visiting [RStudio's public package manager](https://packagemanager.rstudio.com/client/#/repos/1/overview) and choosing the binary repository appropriate for your linux distro. Run `renv::modify` and change the URL line to the one from Package Manager before running `renv::restore`.
3) Add an RStudio Connect API Key and Server to the `.Rprofile` file included. You can get an API Key using [these instructions](https://docs.rstudio.com/connect/user/api-keys/).

