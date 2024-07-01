terraform {
  backend "s3" {
    bucket  = "test-project-bucket"
    key     = "terraform.tfstate"
    region  = "us-east-1"  # Updated region
    encrypt = true
  }
}

