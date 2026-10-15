What is terraform? why do we need it?
Terraform is an IaC tool - infrastructure as code. It lets us provision and manage infrastructure using code.

why do we need it.
- to automate the task of infrastructure provisioning instead of manually doing it.
- less error prone
- Reusability - we can reuse the same code to setup multiple environments
e.g. dev testing staging and production.
- Consistency -> we can achieve same infrastructure across environments
- Version control - Store infrastructure code in github and track changes.

# Difference between terraform and ansible
Terraform lets us provision infra or servers using code
Ansible is a configuration management tool which configures what inside goes them servers.
It helps you install, configure, and maintain software on servers automatically.

- You write an Ansible playbook (playbook basically has instructions written in it like install apache start it and enable it)-> Ansible executes the instructions basically connects to your servers using ssh 

tee command - saves an output of a command to a file
e.g. ls -l | tee output.txt

> /dev/null - discard the command output instead of displaying it on terminal

# main.tf
terraform code 
# step 1 terraform init
> to be able for terraform to read and understand the instructions written in main.tf file
> do terraform init in the directory where your project directory is and it is one time installation which gives an environment to run the configuration file and downloads the required provider plugins such as AWS

# step 2 validate
> to validate if your main.tf configuration is valid or not
> use terraform validate

# step 3 plan
> command - terraform plan
> it's like a preview of what is going to happen when the code will run

> argument (inside the curly brackets in main.tf) - before the execution
> attribute -  after you apply or execute

# step 4 apply
> to run the main.tf file 
> to execute the instructions in the main.tf file
> command - terraform apply

# to remove use
> terraform destroy or use
> terraform destroy -auto-approve to remove the prompt e.g yes

 # Providers
 > In Terraform, providers are plugins that allow Terraform to interact with platforms and services such as AWS, Azure, Docker, and Kubernetes.

 > Suppose if i want to create something on aws in Terraform
 > So here AWS is the provider that allow tf to interact with AWS to create resources on aws using terraform. 