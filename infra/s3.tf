resource "aws_s3_bucket" "terraform-tfstate" {
  bucket = "terraform-tfstate-wedding-line-bot"
}
resource "aws_s3_bucket_acl" "terraform-tfstate" {
  bucket = aws_s3_bucket.terraform-tfstate.id
  acl    = "private"
}
resource "aws_s3_bucket_versioning" "terraform-tfstate" {
  bucket = aws_s3_bucket.terraform-tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_kms_key" "terraform-tfstate-bucket" {
  description             = "This key is used to encrypt terraform tfstate bucket objects"
  deletion_window_in_days = 10
}
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-tfstate" {
  bucket = aws_s3_bucket.terraform-tfstate.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.terraform-tfstate-bucket.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
