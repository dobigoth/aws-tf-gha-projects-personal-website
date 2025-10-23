provider "aws" {

}

terraform {
  backend "s3" {
    bucket  = "tf-resources-gha-dg2"
    region  = "ap-southeast-1"
    key     = "github-actions/terraform.tfstate"
    encrypt = true
    dynamodb_table = "tf-resources-gha-lock"
  }
}
