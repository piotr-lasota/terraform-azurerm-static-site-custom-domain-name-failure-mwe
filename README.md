# Issue overview
When using `azurerm_static_site_custom_domain` validated via `dns-txt-token`
one can successfully `validate`, `plan` and `apply` the infrastructure
presented in this minimum reproducible example.
As long as validation is not complete for the `txt` token on the `azurerm_static_site_custom_domain`
then all this works.

As soon as the validation is complete any attempts to `plan` or 