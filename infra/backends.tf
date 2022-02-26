terraform {
  backend "s3" {
    profile = "sandbox"
    region  = "ap-northeast-1"
    bucket  = "terraform-tfstate-wedding-line-bot"
    key     = "terraform.tfstate"
    encrypt = true

    dynamodb_table = "terraform_state_lock_wedding_line_bot"
  }
}
