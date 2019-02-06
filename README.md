Connect User Management
============================

The RStudio Connect Server API has endpoints to manage
users and groups.

This repository houses some examples that might be useful in
your organization.

- [Email that Reports New Users on RStudio Connect](./email_new_users.Rmd)
    - Configurable "lookback" period
    - Checks if any users were created within the last X days (i.e. last day)
    - Shows the data for those users
    - Sends an email with the user, email, and created time
  
