module "lambda_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  name        = "wedding-line-bot-lambda_security_group"
  description = "Security group for Lambda of wedding-line-bot."
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}
