module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = var.vpc_name
  vpc_cidr_block       = var.vpc_cidr_block
  aws_region           = var.aws_region
  naming_prefix        = local.naming_prefix
  enable_dns_hostnames = true
  enable_dns_support   = true
  common_tags          = local.common_tags
  aws_azs              = var.aws_azs
}

module "bastion_host" {
  source           = "./modules/bastion"
  vpc_id           = module.vpc.vpc_id
  instance_type    = var.instance_type
  sg_ingress_ports = var.sg_ingress_public
  ec2_name         = var.ec2_name
  naming_prefix    = local.naming_prefix
  key_name         = var.key_name
  subnet_id        = module.vpc.public_subnets[0]
  common_tags      = local.common_tags
depends_on = [ module.vpc ]
}

module "eks_cluester" {
  source                              = "./modules/eks-cluster"
  eks_cluster_name                    = var.eks_cluster_name
  eks_cluster_version                 = var.eks_cluster_version
  eks_cluster_endpoint_private_access = var.eks_cluster_endpoint_private_access
  eks_cluster_endpoint_public_access  = var.eks_cluster_endpoint_public_access
  eks_cluster_service_ipv4_cidr       = var.eks_cluster_service_ipv4_cidr
  eks_cluster_endpoint_access_cidrs   = var.eks_cluster_endpoint_access_cidrs
  private_subnets                     = module.vpc.private_subnets
  public_subnets                      = module.vpc.public_subnets
  naming_prefix                       = local.naming_prefix
  common_tags                         = local.common_tags
  depends_on                          = [module.vpc]
}

# module "eks_cluster_admin_users" {
#   source                             = "./modules/eks-admin-users"
#   naming_prefix                      = local.naming_prefix
#   common_tags                        = local.common_tags
#   cluster_certificate_authority_data = module.eks_cluester.cluster_certificate_authority_data
#   cluster_endpoint                   = module.eks_cluester.cluster_endpoint
#   cluster_id                         = module.eks_cluester.cluster_id
#   eks_admin_user                     = var.eks_admin_user
#   eks_basic_user                     = var.eks_basic_user
#   eks_worker_node_role_name          = var.eks_worker_node_role_name


# }


module "eks_cluster_admin_with_role" {
  source                             = "./modules/eks-admins-with-iam-roles"
  common_tags                        = local.common_tags
  cluster_certificate_authority_data = module.eks_cluester.cluster_certificate_authority_data
  cluster_endpoint                   = module.eks_cluester.cluster_endpoint
  cluster_id                         = module.eks_cluester.cluster_id
  eks_admin_user                     = var.eks_admin_user
  eks_basic_user                     = var.eks_basic_user
  eks_worker_node_role_name          = var.eks_worker_node_role_name
  eks_admin_group_name               = "eksadmins"
  eks_admin_role_name                = "eks-admin-role"
  naming_prefix                      = local.naming_prefix
  eks_readonly_role_name             = "eks_readonly_role"
  eks_read_only_group_name           = "eksreadonly"
  eksreadonly_user_name              = "eksreadonly1"
  eks_developer_user_name = "eksdeveloper1"
}

module "eks_node_group_public_private" {
  source                      = "./modules/eks-node-group"
  eks_cluster_node_group_name = var.eks_cluster_node_group_name
  eks_cluster_name            = module.eks_cluester.eks_cluster_name
  capacity_type               = var.capacity_type
  eks_cluster_version         = var.eks_cluster_version
  common_tags                 = local.common_tags
  naming_prefix               = local.naming_prefix
  key_name                    = var.key_name
  public_subnets              = module.vpc.public_subnets
  private_subnets             = module.vpc.private_subnets
  instance_types              = var.instance_types
  depends_on                  = [module.eks_cluster_admin_with_role]
}







