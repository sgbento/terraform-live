output "instance_public_ip" {
  description = "Public IP of your EC2 instance — use this to SSH in"
  value       = aws_instance.playground.public_ip
}

output "ssh_command" {
  description = "Ready-to-run SSH command"
  value       = "ssh -i ~/.ssh/${var.key_pair_name}.pem ec2-user@${aws_instance.playground.public_ip}"
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "ami_used" {
  description = "Amazon Linux AMI that was used"
  value       = data.aws_ami.amazon_linux.name
}
