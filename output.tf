
output "network" {
  description = "VPC ID, ARN, and subnet information"
  value = {
    vpc_arn         = aws_vpc.tf_vpc.arn
    vpc_id          = aws_vpc.tf_vpc.arn
    public_subnets  = [aws_subnet.tf_subnet_public_1.id, aws_subnet.tf_subnet_public_2.id, aws_subnet.tf_subnet_public_3.id]
    private_subnets = [aws_subnet.tf_subnet_internal_1.id, aws_subnet.tf_subnet_internal_2.id, aws_subnet.tf_subnet_internal_3.id]
  }
}

output "instance_ip" {
  description = "Public IP of server"
  value = aws_instance.dev_node.public_ip
}