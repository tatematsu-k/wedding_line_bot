module "ecs_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  name        = "wedding-line-bot-ecs_security_group"
  description = "Security group for ecs of wedding-line-bot."
  vpc_id      = module.vpc.vpc_id
}
