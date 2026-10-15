<block> <parameter> {
    arguments
}

resource - resource block (e.g ec2 inst, docker cont etc.)
output - output block
store variabes - variable block

parameter - about the block 
e.g. resource block, name and it's type 
type(e.g. ec2 , s3)

example

<block> <parameter> {
    arguments
}

block    type of resource name of resource
resource ec2_instance     my_instance {
    arguments
    instance_type
    instance_storage
    instance_name

}