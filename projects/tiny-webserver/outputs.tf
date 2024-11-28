output "alb_dns_name" {
  value       = module.aws_asg_elb_cluster.alb_dns_name
  description = "The domain name of the load balancer"
}