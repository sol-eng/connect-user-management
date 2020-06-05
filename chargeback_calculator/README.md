# Setup
1) Open the chargeback_counter project by opening the `chargeback_counter.Rproj` in the RStudio IDE.
2) Restore the R packages by running `renv::restore`.
  - If you are on a Linux system, you may wish to change the restore to use binary packages from RStudio Package Manager, as installs will be much faster. You can do this by visiting [RStudio's public package manager](https://packagemanager.rstudio.com/client/#/repos/1/overview) and choosing the binary repository appropriate for your linux distro. Run `renv::modify` and change the URL line to the one from Package Manager before running `renv::restore`.
3) Add an RStudio Connect API Key and Server to the `.Rprofile` file included. You can get an API Key using [these instructions](https://docs.rstudio.com/connect/1.7.4/user/api-keys.html#api-keys).