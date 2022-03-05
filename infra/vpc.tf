module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  version = "3.12.0"

  name = "wedding-line-bot"

  cidr = "11.0.0.0/16"

  azs             = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  private_subnets = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
  public_subnets  = ["11.0.101.0/24", "11.0.102.0/24", "11.0.103.0/24"]

  # 高いのでnat instanceで誤魔化す
  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true

  tags = {
    terraform = "true"
    service   = "wedding-line-bot"
  }
}
# module "nat" {
#   source = "int128/nat-instance/aws"

#   name                        = "nat-instance"
#   vpc_id                      = module.vpc.vpc_id
#   public_subnet               = module.vpc.public_subnets[0]
#   private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
#   private_route_table_ids     = module.vpc.private_route_table_ids
# }
