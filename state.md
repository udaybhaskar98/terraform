# Terraform state
> Terraform state is a file that remembers (keep record of) the infrastructure Terraform manages.
By default, Terraform stores it in a file called terraform.tfstate.

Terraform creates the instance in AWS.
It records details about them in its state file such as their resource IDs.
Next time you run terraform plan , Terraform uses the state to understand
what is already manages (has bee built) and what changes are needed.

# State Management
State management means maintaining and managing that state file safely and correctly.

includes:
Tracking resources, Updating State - keeping it sync with infrastructure changes (means state in aws to state in terraform state file)
Storing state safely
Sharing State - allowing multiple team memebers to work on the same infrastructure safely.

# Why do we need/use import?
> We use import when a resource already exists in AWS but Terraform isn't tracking it in its state file

> e.g For example, your S3 bucket demo-buck3t-tf2 already exists in AWS, but you removed it from Terraform state.
- Without import: Terraform may think the bucket isn't tracked and attempt to create it again, causing a name conflict.
- With import: Terraform connects the existing bucket to aws_s3_bucket.bucket_res in Terraform state.


## Terraform State Locking

**What is state locking?**
- Prevents multiple Terraform operations from modifying the same state file at the same time.
- Helps avoid state corruption and conflicts.

**How does it work?**
1. Terraform acquires a lock before modifying state.
2. Other Terraform operations that need the lock must wait or fail.
3. After the operation finishes, Terraform releases the lock.

**How to enable state locking with AWS S3 backend and DynamoDB (legacy method):**

```hcl
terraform {
  backend "s3" {
    bucket         = "my-state-bucket"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }
}
```

DynamoDB table requirements:
- Partition key: `LockID`
- Type: `String`
- No sort key required.

Run `terraform init` after configuring the backend.

**Important:**
- `dynamodb_table` locking is deprecated in newer Terraform versions.
- The S3 backend now supports native locking with `use_lockfile = true`:

```hcl
terraform {
  backend "s3" {
    bucket       = "my-state-bucket"
    key          = "terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
```

- S3-native locking requires appropriate S3 permissions.
- Never manually delete a lock while Terraform may still be running.
