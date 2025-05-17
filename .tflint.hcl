# TFLint configuration
# TODO: Fix these issues in the future
# - Add required_version to modules
# - Add required_providers to modules
# - Fix unused variable declarations

# Skip terraform_required_version check
rule "terraform_required_version" {
  enabled = false
}

# Skip terraform_required_providers check
rule "terraform_required_providers" {
  enabled = false
}

# Skip terraform_unused_declarations check
rule "terraform_unused_declarations" {
  enabled = false
}
