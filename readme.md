# Infrastructure of the blog project

This infrastructure is related to the other two project that I develop or I'm developing. You can found theses project in my repository. This infrastructure code is for Digital ocean platform.

## Environment variables

You need a few environment variables to make works this project in digital ocean. You'll a token provided by digital ocean and this token have to be accesible from your environment variables with a special name:

````bash
export TF_DO_TOKEN=<your-token-here>
````

Terraform will read all environment variables that starts with ``TF_`` and it'll bind with the variables that you define. In this case:

````hcl
variable "do_token" {}
````

This variable defined in a terraform file will match with their respective environment variable.

