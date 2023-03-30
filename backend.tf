terraform {
  backend "s3" {
    bucket = "serves-terraform"
    key    = "terraform.tfstate"
    region = "eu-west-2"
    #dynamodb_table = "my-terraform-state-lock"
  }
}