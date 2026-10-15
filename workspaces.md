## Terraform Workspaces

**What are workspaces?**
- Workspaces allow us to manage multiple separate Terraform states using the same configuration.
- Each workspace has its own state file and tracks its own set of resources.

**Why use workspaces?**
- To manage separate environments such as `dev`, `test`, and `prod` using the same Terraform code.
- Resources tracked in one workspace are tracked separately from other workspaces.

**Common commands:**

```bash
# List workspaces
terraform workspace list

# Create a workspace
terraform workspace new dev

# Switch workspace
terraform workspace select dev

# Show current workspace
terraform workspace show

# Delete a workspace
terraform workspace delete dev
```

**Default workspace:**
- Terraform creates a workspace named `default` automatically.
- You cannot delete the `default` workspace.

**How state is separated:**
- With the local backend, each workspace has a separate state file.
- With an S3 backend, non-default workspaces typically use a workspace-specific state path, controlled by `workspace_key_prefix` (default: `env:`).

**Important:**
- Workspaces share the same Terraform configuration but maintain separate state.
- Workspaces do not automatically isolate AWS resources, credentials, permissions, or infrastructure.
- For strong production isolation, separate configurations or accounts may be more appropriate.
